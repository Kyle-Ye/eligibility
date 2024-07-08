//
//  EligibilityEngine.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import "EligibilityEngine.h"
#import "EligibilityLog.h"
#import "EligibilityUtils.h"
#import "GlobalConfiguration.h"
#import "TestDomain.h"
#import "XcodeLLMDomain.h"

@interface EligibilityEngine ()

- (NSDictionary *)_createDefaultDomains;
- (void)_currentLocaleDidChange:(NSNotification *)notification;
- (id)_decodeObjectOfClasses:(NSSet *)classes atURL:(NSURL *)url withError:(NSError * _Nullable *)errorPtr;
- (EligibilityOverride *)_loadOverridesWithError:(NSError **)errorPtr;
- (NSDictionary *)_loadDomainsWithError:(NSError **)errorPtr;

- (void)_onQueue_recomputeAllDomainAnswers;

@end

@implementation EligibilityEngine

+ (instancetype)sharedInstance {
    static EligibilityEngine *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableDictionary *defaultDomains = [self _createDefaultDomains].mutableCopy;
        NSError *error = nil;
        NSDictionary *loadedDomains = [self _loadDomainsWithError:&error];
        if (!loadedDomains) {
            os_log(eligibility_log(), "%s: Unable to load serialized domains, initing with empty values: %@", __func__, error);
            error = nil;
        } else {
            [defaultDomains addEntriesFromDictionary:loadedDomains];
        }
        _domains = defaultDomains.copy;
        id loadedOverrides = [self _loadOverridesWithError:&error];
        if (!loadedOverrides) {
            os_log(eligibility_log(), "%s: Unable to load serialized overrides, initing with no overrides: %@", __func__, error);
            loadedOverrides = [EligibilityOverride new];
        }
        _eligibilityOverrides = loadedOverrides;
        _notificationsToSend = [NSMutableSet new];
        dispatch_queue_attr_t internalQueueAttr = dispatch_queue_attr_make_with_autorelease_frequency(nil, DISPATCH_AUTORELEASE_FREQUENCY_WORK_ITEM);
        dispatch_queue_t internalQueue = dispatch_queue_create("com.apple.eligibility.EligibilityEngine.internal", internalQueueAttr);
        _internalQueue = internalQueue;
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_currentLocaleDidChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
    }
    return self;
}

- (NSDictionary *)_createDefaultDomains {
    NSDictionary *domains = @{
        eligibility_domain_to_NSString(EligibilityDomainTypeXcodeLLM): [XcodeLLMDomain new],
    }; // TODO: Add more domains
    
    if (GlobalConfiguration.sharedInstance.hasInternalContent) {
        NSMutableDictionary *mutable = domains.mutableCopy;
        mutable[eligibility_domain_to_NSString(EligibilityDomainTypeTest)] = [TestDomain new];
        domains = mutable.copy;
    }
    return domains;
}

- (void)_currentLocaleDidChange:(NSNotification *)notification {
    [self recomputeAllDomainAnswers];
}

- (id)_decodeObjectOfClasses:(NSSet *)classes atURL:(NSURL *)url withError:(NSError **)errorPtr {
    NSError *readinessError = nil;
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe | NSDataReadingUncached error:&readinessError];
    if (!data) {
        if ([readinessError.domain isEqualToString:NSCocoaErrorDomain] && readinessError.code == NSFileReadNoSuchFileError) {
            os_log(eligibility_log(), "%s: URL %@ doesn't exist yet: %@", __func__, url.path, readinessError);
        } else {
            os_log_error(eligibility_log(), "%s: Failed to deserialize data in %@: %@", __func__, url.path, readinessError);
        }
        if (!errorPtr) {
            *errorPtr = readinessError;
        }
        return nil;
    }
    
    NSError *unarchiveError = nil;
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&unarchiveError];
    if (!unarchiver) {
        os_log_error(eligibility_log(), "%s: Failed to create unarchiver: %@", __func__, unarchiveError);
        if (!errorPtr) {
            *errorPtr = unarchiveError;
        }
        return nil;
    }
    
    id decoded = [unarchiver decodeObjectOfClasses:classes forKey:NSKeyedArchiveRootObjectKey];
    if (!decoded) {
        os_log_error(eligibility_log(), "%s: Failed to decode data at %@ : %@", __func__, url.path, unarchiver.error);
        if (!errorPtr) {
            *errorPtr = unarchiver.error;
        }
        return nil;
    }
    
    [unarchiver finishDecoding];
    return decoded;
}

- (EligibilityOverride *)_loadOverridesWithError:(NSError **)errorPtr {
    NSError *error = nil;
    NSURL *container = OEURLForContainerWithError(&error);
    EligibilityOverride *decoded;
    if (!container) {
        os_log_error(eligibility_log(), "%s: Failed to obtain the URL for our data container: %@", __func__, error);
        decoded = nil;
    } else {
        NSURL *url = [container URLByAppendingPathComponent:@"Library/Caches/NeverRestore/eligibility_overrides.data" isDirectory:NO];
        decoded = [self _decodeObjectOfClasses:[NSSet setWithObjects:EligibilityOverride.class, nil] atURL:url withError:&error];
        if (!decoded) {
            os_log_error(eligibility_log(), "%s: Failed to decode overrides: %@", __func__, error);
        } else {
            error = nil;
        }
    }
    if (errorPtr != nil) {
        *errorPtr = error;
    }
    return decoded;
}

- (NSDictionary *)_loadDomainsWithError:(NSError **)errorPtr {
    NSSet *classes = [NSSet setWithObjects:NSDictionary.class, EligibilityDomain.class, NSString.class, nil];
    const char *path = copy_eligibility_domain_domains_serialization_path();
    NSDictionary *decoded;
    NSError *error;
    if (!path) {
        os_log_error(eligibility_log(), "%s: Failed to copy domains serialization path", __func__);
        decoded = nil;
        error = nil;
    } else {
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithUTF8String:path] isDirectory:NO];
        NSError *decodeError = nil;
        decoded = [self _decodeObjectOfClasses:classes atURL:url withError:&decodeError];
        if (!decoded) {
            os_log_error(eligibility_log(), "%s: Failed to decode domains: %@", __func__, decodeError);
        }
        error = decodeError;
    }
    free((void *)path);
    if (errorPtr != nil && decoded == nil) {
        *errorPtr = error;
    }
    return decoded;
}

- (void)recomputeAllDomainAnswers {
    dispatch_async(self.internalQueue, ^{
        [self _onQueue_recomputeAllDomainAnswers];
    });
}

- (void)_onQueue_recomputeAllDomainAnswers {
    // TODO
}

- (void)scheduleDailyRecompute {
    // TODO
}

@end
