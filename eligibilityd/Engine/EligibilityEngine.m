//
//  EligibilityEngine.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import "EligibilityEngine.h"
#import "GlobalConfiguration.h"
#import "EligibilityLog.h"

#import "TestDomain.h"
#import "XcodeLLMDomain.h"

@interface EligibilityEngine ()

- (NSDictionary *)_createDefaultDomains;
- (void)_currentLocaleDidChange:(NSNotification *)notification;
- (id)_decodeObjectOfClasses:(NSSet *)classes atURL:(NSURL *)url withError:(NSError * _Nullable *)errorPtr;
- (id)_loadOverridesWithError:(NSError * _Nullable *)errorPtr;
- (id)_loadDomainsWithError:(NSError * _Nullable *)errorPtr;

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
        // TODO
        dispatch_queue_attr_t internalQueueAttr = dispatch_queue_attr_make_with_autorelease_frequency(nil, DISPATCH_AUTORELEASE_FREQUENCY_WORK_ITEM);
        dispatch_queue_t internalQueue = dispatch_queue_create("com.apple.eligibility.EligibilityEngine.internal", internalQueueAttr);
        _internalQueue = internalQueue;
        // TODO
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

- (id)_decodeObjectOfClasses:(NSSet *)classes atURL:(NSURL *)url withError:(NSError * _Nullable *)errorPtr {
    NSError *readinessError = nil;
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe | NSDataReadingUncached error:&readinessError];
    if (!data) {
        if ([readinessError.domain isEqualToString:NSCocoaErrorDomain] && readinessError.code == NSFileReadNoSuchFileError) {
            os_log(eligibility_log(), "%s: URL %@ doesn't exist yet: %@", __FUNCTION__, url.path, readinessError);
        } else {
            os_log_error(eligibility_log(), "%s: Failed to deserialize data in %@: %@", __FUNCTION__, url.path, readinessError);
        }
        if (!errorPtr) {
            *errorPtr = readinessError;
        }
        return nil;
    }
    
    NSError *unarchiveError = nil;
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&unarchiveError];
    if (!unarchiver) {
        os_log_error(eligibility_log(), "%s: Failed to create unarchiver: %@", __FUNCTION__, unarchiveError);
        if (!errorPtr) {
            *errorPtr = unarchiveError;
        }
        return nil;
    }
    
    id decoded = [unarchiver decodeObjectOfClasses:classes forKey:NSKeyedArchiveRootObjectKey];
    if (!decoded) {
        os_log_error(eligibility_log(), "%s: Failed to decode data at %@ : %@", __FUNCTION__, url.path, unarchiver.error);
        if (!errorPtr) {
            *errorPtr = unarchiver.error;
        }
        return nil;
    }
    
    [unarchiver finishDecoding];
    return decoded;
}

- (id)_loadOverridesWithError:(NSError * _Nullable __autoreleasing *)errorPtr {
    // TODO
    return nil;
}

- (id)_loadDomainsWithError:(NSError * _Nullable __autoreleasing *)errorPtr {
    // TODO
    return nil;
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
