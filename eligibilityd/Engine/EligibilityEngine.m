//
//  EligibilityEngine.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityEngine.h"
#import "EligibilityLog.h"
#import "EligibilityUtils.h"
#import "InputManager.h"
#import "GlobalConfiguration.h"
#import "LocatedCountryInput.h"
#import "TestDomain.h"
#import "GreymatterDomain.h"
#import "XcodeLLMDomain.h"
#import "EligibilityDomainTypeHelper.h"
#import "BackgroundSystemTasks.h"
#import "MobileAssetManager.h"
#import "XPCSPI.h"
#import <notify.h>

@interface EligibilityEngine ()

- (NSDictionary *)_createDefaultDomains;
- (void)_currentLocaleDidChange:(NSNotification *)notification;
- (id)_decodeObjectOfClasses:(NSSet *)classes atURL:(NSURL *)url withError:(NSError * _Nullable *)errorPtr;
- (EligibilityOverride *)_loadOverridesWithError:(NSError **)errorPtr;
- (NSDictionary *)_loadDomainsWithError:(NSError **)errorPtr;
- (BOOL)_onQueue_saveDomainsWithError:(NSError **)errorPtr;
- (BOOL)_serializeObject:(id)object toURL:(NSURL *)url withError:(NSError **)errorPtr;
- (BOOL)_onQueue_serializeOverrideDataToDiskWithError:(NSError **)errorPtr;
- (BOOL)_onQueue_serializeInternalDomainStateToDiskWithError:(NSError **)errorPtr;
- (NSDictionary *)_onQueue_finalEligibilityDictionaryForDomain:(EligibilityDomain *)domain;
- (NSDictionary *)_onQueue_urlToDomainData;
- (BOOL)_onQueue_saveDomainAnswerOutputsWithError:(NSError **)errorPtr;
- (BOOL)_sendNotification:(NSNotificationName)notifictation;
- (void)_onQueue_sendNotifications;
- (void)_onQueue_recomputeAllDomainAnswers;
- (void)_onQueue_handleRecompute:(BGSystemTask *)task;
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
        eligibility_domain_to_NSString(EligibilityDomainTypeGreymatter): [GreymatterDomain new],
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

- (BOOL)_onQueue_saveDomainsWithError:(NSError **)errorPtr {
    dispatch_assert_queue(self.internalQueue);
    BOOL result;
    NSError *error = nil;
    if ([self _onQueue_serializeInternalDomainStateToDiskWithError:&error] && [self _onQueue_saveDomainAnswerOutputsWithError:&error] && [self _onQueue_serializeOverrideDataToDiskWithError:&error]) {
        result = YES;
    } else {
        result = NO;
    }
    if (!result && errorPtr) {
        *errorPtr = error;
    }
    return result;
}

- (BOOL)_serializeObject:(id)object toURL:(NSURL *)url withError:(NSError **)errorPtr {
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:YES];
    [archiver encodeObject:object forKey:NSKeyedArchiveRootObjectKey];
    NSData *encodedData = [archiver encodedData];
    NSError *writingError = nil;
    BOOL writeResult = [encodedData writeToURL:url options:NSDataWritingAtomic | NSDataWritingFileProtectionNone error:&writingError];
    BOOL result;
    NSError *error;
    if (writeResult) {
        error = nil;
        result = YES;
    } else {
        os_log_error(eligibility_log(), "%s: Failed to write data %@ to disk at %@: %@", __func__, object, url.path, writingError);
        error = writingError;
        result = NO;
    }
    if (!result && errorPtr) {
        *errorPtr = error;
    }
    return result;
}

- (BOOL)_onQueue_serializeOverrideDataToDiskWithError:(NSError **)errorPtr {
    dispatch_assert_queue(self.internalQueue);
    NSError *error = nil;
    NSURL *container = OEURLForContainerWithError(&error);
    BOOL result;
    if (!container) {
        os_log_error(eligibility_log(), "%s: Failed to obtain the URL for our data container: %@", __func__, error);
        result = NO;
    } else {
        NSURL *url = [container URLByAppendingPathComponent:@"Library/Caches/NeverRestore/eligibility_overrides.data" isDirectory:NO];
        BOOL success = [self _serializeObject:self.eligibilityOverrides toURL:url withError:&error];
        if (success) {
            result = YES;
        } else {
            os_log(eligibility_log(), "%s: Failed to write eligibility overrides data to disk: %@", __func__, error);
            result = NO;
        }
    }
    if (!result && errorPtr != nil) {
        *errorPtr = error;
    }
    return result;
}

- (BOOL)_onQueue_serializeInternalDomainStateToDiskWithError:(NSError **)errorPtr {
    dispatch_assert_queue(self.internalQueue);
    const char *path = copy_eligibility_domain_domains_serialization_path();
    BOOL result;
    NSError *error;
    if (path == NULL) {
        os_log_fault(eligibility_log(), "%s: Failed to copy domains serialization path", __func__);
        error = nil;
        result = NO;
    } else {
        NSString *string = [NSString stringWithUTF8String:path];
        NSURL *url = [NSURL fileURLWithPath:string isDirectory:NO];
        NSError *serializeError = nil;
        BOOL success = [self _serializeObject:self.domains toURL:url withError:&serializeError];
        if (success) {
            error = nil;
            result = YES;
        } else {
            os_log(eligibility_log(), "%s: Failed to write domain data to disk: %@", __func__, serializeError);
            error = serializeError;
            result = NO;
        }
    }
    free((void *)path);
    if (!result && errorPtr) {
        *errorPtr = error;
    }
    return result;
}

- (NSDictionary *)_onQueue_finalEligibilityDictionaryForDomain:(EligibilityDomain *)domain {
    dispatch_assert_queue(self.internalQueue);
    NSDictionary *overrideResult = [self.eligibilityOverrides overrideResultDictionaryForDomain:domain.domain];
    return overrideResult ?: [domain serialize];
}

- (NSDictionary *)_onQueue_urlToDomainData {
    dispatch_assert_queue(self.internalQueue);
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [self.domains enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, __kindof EligibilityDomain * _Nonnull obj, BOOL * _Nonnull stop) {
        const char *path = eligibility_plist_path_for_domain(obj.domain);
        if (path == NULL) {
            os_log_fault(eligibility_log(), "%s: Skipping domain %@ because it doesn't have a plist specified", __func__, obj);
        } else {
            NSString *string = [NSString stringWithUTF8String:path];
            free((void *)path);
            NSURL *url = [NSURL fileURLWithPath:string isDirectory:NO];
            if (dict[url] == NULL) {
                dict[url] = [NSMutableDictionary new];
            }
            dict[url][key] = [self _onQueue_finalEligibilityDictionaryForDomain:obj];
        }
    }];
    return dict.copy;
}

- (BOOL)_onQueue_saveDomainAnswerOutputsWithError:(NSError **)errorPtr {
    dispatch_assert_queue(self.internalQueue);
    NSDictionary *domainData = [self _onQueue_urlToDomainData];
    __block NSError *blockError = nil;
    __block BOOL blockResult = NO;
    [domainData enumerateKeysAndObjectsUsingBlock:^(NSURL * _Nonnull key, NSMutableDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        NSError *error = nil;
        NSData *data = [NSPropertyListSerialization dataWithPropertyList:obj format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
        if (data == NULL) {
            os_log_error(eligibility_log(), "%s: Failed to write answer plist %@: %@", __func__, key.path, error);
            blockError = error;
        } else {
            NSError *writingError = nil;
            BOOL writeResult = [data writeToURL:key options:NSDataWritingAtomic | NSDataWritingFileProtectionNone error:&writingError];
            if (writeResult) {
                blockResult = YES;
            } else {
                os_log_error(eligibility_log(), "%s: Failed to write answer plist %@: %@", __func__, key.path, writingError);
                blockError = writingError;
            }
        }
    }];
    if (!blockResult && errorPtr) {
        *errorPtr = blockError;
    }
    return blockResult;
}

- (BOOL)_sendNotification:(NSNotificationName)notifictation {
    const char *name = notifictation.UTF8String;
    uint32_t status = notify_post(name);
    if (status != 0) {
        os_log_error(eligibility_log(), "%s: Could not post domain change notification \\\"%s\\\": %u", __func__, name, status);
    }
    return status == 0;
}

- (void)_onQueue_sendNotifications {
    dispatch_assert_queue(self.internalQueue);
    NSMutableSet<NSNotificationName> *notifications = self.notificationsToSend;
    if (notifications.count != 0) {
        [notifications addObject:@"com.apple.os-eligibility-domain.change"];
    }
    for (NSNotificationName notification in notifications.copy) {
        if ([self _sendNotification:notification]) {
            [notifications removeObject:notification];
        }
    }
}

- (void)recomputeAllDomainAnswers {
    dispatch_sync(self.internalQueue, ^{
        [self _onQueue_recomputeAllDomainAnswers];
    });
}

- (void)_onQueue_recomputeAllDomainAnswers {
    dispatch_assert_queue(self.internalQueue);
    [self.domains enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, __kindof EligibilityDomain * _Nonnull obj, BOOL * _Nonnull stop) {
        EligibilityAnswer oldAnswer = obj.answer;
        NSError *error = nil;
        if ([obj computeWithError:&error] == EligibilityAnswerInvalid) {
            os_log_error(eligibility_log(), "%s: Failed to compute eligibility for domain %@: %@", __func__, key ,error);
        } else {
            if (obj.answer != oldAnswer) {
                [self.notificationsToSend addObject:obj.domainChangeNotificationName];
            }
        }
    }];
    NSError *error = nil;
    if ([self _onQueue_saveDomainsWithError:&error]) {
        [self _onQueue_sendNotifications];
    } else {
        os_log_error(eligibility_log(), "%s: Failed to save domains to disk: %@", __func__, error);
    }
}

- (BOOL)setInput:(EligibilityInputType)inputType to:(xpc_object_t)object status:(EligibilityInputStatus)status fromProcess:(NSString *)process withError:(NSError **)errorPtr {
    EligibilityInput *input;
    switch (inputType) {
        case EligibilityInputTypeCountryLocation:
            input = [[LocatedCountryInput alloc] initWithCountryCodes:object status:status process:process];
            break;
        case EligibilityInputTypeCountryBilling:
            input = [[CountryBillingInput alloc] initWithBillingCountry:object status:status process:process];
            break;
        case EligibilityInputTypeDeviceLocale:
            input = [[DeviceLocaleInput alloc] initWithDeviceLocale:object status:status process:process];
            break;
        case EligibilityInputTypeGreyMatterOnQueue:
            input = [[GreymatterQueueInput alloc] initOnQueue:object status:status process:process];
            break;
        default: {
            os_log_error(eligibility_log(), "%s: Unsupported input type: %llu", __func__, (uint64_t)inputType);
            NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
            if (errorPtr) {
                *errorPtr = error;
            }
            return NO;
        }
    }
    if (input == nil) {
        os_log_error(eligibility_log(), "%s: Failed to initalize input type", __func__);
        NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
        if (errorPtr) {
            *errorPtr = error;
        }
        return NO;
    } else {
        asyncBlock(self.internalQueue, ^{
            NSError *error = nil;
            BOOL result = [InputManager.sharedInstance setInput:input withError:&error];
            if (result) {
                [self _onQueue_recomputeAllDomainAnswers];
            } else {
                os_log_error(eligibility_log(), "%s: Failed to set input value: %@", __func__, error);
            }
        });
        return YES;
    }
}

- (BOOL)resetDomain:(EligibilityDomainType)domain_type withError:(NSError **)errorPtr {
    const char *domain_str = eligibility_domain_to_str(domain_type);
    if (domain_type == EligibilityDomainTypeInvalid || domain_str == NULL) {
        NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
        if (errorPtr) {
            *errorPtr = error;
        }
        return NO;
    }
    asyncBlock(self.internalQueue, ^{
        NSString *domainString = [NSString stringWithUTF8String:domain_str];
        EligibilityDomain *domain = self.domains[domainString];
        if (domain == nil) {
            os_log_error(eligibility_log(), "%s: Unknown domain: %llu", __func__, domain_type);
            return;
        }
        [self.eligibilityOverrides resetAnswerForDomain:domain_type];
        NSError *saveError = nil;
        if ([self _onQueue_saveDomainsWithError:&saveError]) {
            [self.notificationsToSend addObject:domain.domainChangeNotificationName];
            [self.notificationsToSend addObject:@"com.apple.os-eligibility-domain.input-needed"];
            [self _onQueue_sendNotifications];
        } else {
            os_log_error(eligibility_log(), "%s: Failed to save updated eligibility to disk: %@", __func__, saveError);
        }
    });
    return YES;
}

- (BOOL)resetAllDomainsWithError:(NSError **)errorPtr {
    asyncBlock(self.internalQueue, ^{
        NSMutableSet *notifications = self.notificationsToSend;
        for (EligibilityDomain * domain in self.domains.allValues) {
            [self.eligibilityOverrides resetAnswerForDomain:domain.domain];
            [notifications addObject:domain.domainChangeNotificationName];
        }
        NSError *saveError = nil;
        if ([self _onQueue_saveDomainsWithError:&saveError]) {
            [self.notificationsToSend addObject:@"com.apple.os-eligibility-domain.input-needed"];
            [self _onQueue_sendNotifications];
        } else {
            os_log_error(eligibility_log(), "%s: Failed to save updated eligibility to disk: %@", __func__, saveError);
        }
    });
    return YES;
}

- (BOOL)forceDomainAnswer:(EligibilityDomainType)domain_type answer:(EligibilityAnswer)answer context:(xpc_object_t)context withError:(NSError **)errorPtr {
    const char *domain_str = eligibility_domain_to_str(domain_type);
    if (domain_type == EligibilityDomainTypeInvalid || domain_str == NULL) {
        NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
        if (errorPtr) {
            *errorPtr = error;
        }
        return NO;
    }
    
    NSDictionary *contextDict = nil;
    if (context) {
        xpc_type_t context_type = xpc_get_type(context);
        if (context_type != XPC_TYPE_DICTIONARY) {
            os_log_error(eligibility_log(), "%s: Expected context to be a dictionary but instead was a %s", __func__, xpc_type_get_name(context_type));
            NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
            if (errorPtr) {
                *errorPtr = error;
            }
            return NO;
        }
        contextDict = (__bridge NSDictionary *)(_CFXPCCreateCFObjectFromXPCObject(context));
    }
    __block NSError *error = nil;
    __block NSNotificationName notificationName = nil;
    dispatch_sync(self.internalQueue, ^{
        NSString *domainString = [NSString stringWithUTF8String:domain_str];
        EligibilityDomain *domain = self.domains[domainString];
        if (domain == nil) {
            os_log_error(eligibility_log(), "%s: Unknown domain: %llu", __func__, domain_type);
            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
            return;
        }
        [self.eligibilityOverrides forceDomain:domain_type answer:answer context:contextDict];
        notificationName = domain.domainChangeNotificationName;
    });
    if (error) {
        if (errorPtr) {
            *errorPtr = error;
        }
        return NO;
    }
    asyncBlock(self.internalQueue, ^{
        NSError *saveError = nil;
        if ([self _onQueue_saveDomainsWithError:&saveError]) {
            [self.notificationsToSend addObject:notificationName];
            [self _onQueue_sendNotifications];
        } else {
            os_log_error(eligibility_log(), "%s: Failed to save updated eligibility to disk: %@", __func__, saveError);
        }
    });
    return YES;
}

- (BOOL)forceDomainSetAnswers:(EligibilityDomainSet)domainSet answer:(EligibilityAnswer)answer context:(xpc_object_t)context withError:(NSError **)errorPtr {
    NSDictionary *contextDict = nil;
    if (context) {
        xpc_type_t context_type = xpc_get_type(context);
        if (context_type != XPC_TYPE_DICTIONARY) {
            os_log_error(eligibility_log(), "%s: Expected context to be a dictionary but instead was a %s", __func__, xpc_type_get_name(context_type));
            NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
            if (errorPtr) {
                *errorPtr = error;
            }
            return NO;
        }
        contextDict = (__bridge NSDictionary *)(_CFXPCCreateCFObjectFromXPCObject(context));
    }
    asyncBlock(self.internalQueue, ^{
        for (EligibilityDomain * domain in self.domains.allValues) {
            EligibilityDomainType domain_type = domain.domain;
            if (domainSet != EligibilityDomainSetDefault) {
                os_log_fault(eligibility_log(), "%s: Checking if a domain %llu is in unknown domain set %llu", __func__, domain_type, domainSet);
                continue;
            }
            switch (domain_type) {
                case EligibilityDomainTypeLotX ... EligibilityDomainTypePotassium:
                case EligibilityDomainTypeScandium ... EligibilityDomainTypeManganese:
                case EligibilityDomainTypeTest:
                case EligibilityDomainTypeGreymatter ... EligibilityDomainTypeSearchMarketplaces:
                    [self.eligibilityOverrides forceDomain:domain.domain answer:answer context:contextDict];
                    [self.notificationsToSend addObject:domain.domainChangeNotificationName];
                    continue;
                default:
                    continue;
            }
            
        }
        NSError *saveError = nil;
        if (![self _onQueue_saveDomainsWithError:&saveError]) {
            os_log_error(eligibility_log(), "%s: Failed to save updated eligibility to disk: %@", __func__, saveError);
        }
        [self _onQueue_sendNotifications];
    });
    return YES;
}

- (NSDictionary *)internalStateWithError:(NSError **)errorPtr {
    NSMutableDictionary *state = [NSMutableDictionary new];
    dispatch_sync(self.internalQueue, ^{
        LocatedCountryInput *countryInput = (LocatedCountryInput *)[InputManager.sharedInstance objectForInputValue:EligibilityInputTypeCountryLocation];
        state[@"OS_ELIGIBILITY_INTERNAL_STATE_COUNTRY_LOCATION"] = countryInput.countryCodes.allObjects;
        BOOL hasActiveGracePeriod = NO;
        for (EligibilityDomain *domain in self.domains.allValues) {
            if (domain.hasActiveGracePeriod) {
                hasActiveGracePeriod = YES;
                break;
            }
        }
        state[@"OS_ELIGIBILITY_INTERNAL_STATE_GRACE_PERIOD_IN_EFFECT"] = @(hasActiveGracePeriod);
    });
    return state.copy;
}

- (NSDictionary *)stateDumpWithError:(NSError **)errorPtr {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dispatch_sync(self.internalQueue, ^{
        dict[@"OS_ELIGIBILITY_STATE_DUMP_INPUTS"] = InputManager.sharedInstance.debugDictionary;
        NSMutableDictionary *domainsDictionary = [NSMutableDictionary new];
        [self.domains enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, __kindof EligibilityDomain * _Nonnull obj, BOOL * _Nonnull stop) {
            domainsDictionary[key] = obj.description;
        }];
        dict[@"OS_ELIGIBILITY_STATE_DUMP_DOMAINS"] = domainsDictionary.copy;
        dict[@"OS_ELIGIBILITY_STATE_DUMP_OVERRIDES"] = self.eligibilityOverrides.description;
        dict[@"OS_ELIGIBILITY_STATE_DUMP_GLOBAL_STATE"] = GlobalConfiguration.sharedInstance.description;
        dict[@"OS_ELIGIBILITY_STATE_DUMP_MOBILE_ASSET"] = MobileAssetManager.sharedInstance.debugDescription;
    });
    return dict.copy;
}

- (BOOL)dumpToDirectory:(NSURL *)directory withError:(NSError **)errorPtr {
    NSURL *plist_url = [directory URLByAppendingPathComponent:@"state.plist" isDirectory:NO];
    BOOL result;
    NSError *error = nil;
    NSDictionary *state = [self stateDumpWithError:&error];
    if (state == nil) {
        os_log_error(eligibility_log(), "%s: Failed to generate state dump: %@", __func__, error);
        result = NO;
    } else {
        NSError *writingErorr = nil;
        BOOL writeResult = [state writeToURL:plist_url error:&writingErorr];
        if (!writeResult) {
            os_log_error(eligibility_log(), "%s: Failed to save state dump to disk: %@", __func__, writingErorr);
            error = writingErorr;
            result = NO;
        } else {
            result = YES;
        }
    }
    if (!result && errorPtr) {
        *errorPtr = error;
    }
    return result;
}

- (void)asyncUpdateAndRecomputeAllAnswers {
    asyncBlock(self.internalQueue, ^{
        for (EligibilityDomain *domain in self.domains.allValues) {
            [domain updateParameters];
        }
        [self _onQueue_recomputeAllDomainAnswers];
    });
}

- (void)_onQueue_handleRecompute:(BGSystemTask *)task {
    dispatch_assert_queue(self.internalQueue);
    NSString *identifier = task.identifier;
    task.expirationHandler = ^{
        os_log_debug(eligibility_log(), "%s: Expiration handler called for %@", __func__, identifier);
    };
    os_log(eligibility_log(), "%s: Refresh MobileAsset parameters", __func__);
    [MobileAssetManager.sharedInstance asyncRefetchMobileAsset];
    // TODO
}

- (void)scheduleDailyRecompute {
    [BGSystemTaskScheduler.sharedScheduler registerForTaskWithIdentifier:@"com.apple.eligibility.recompute"
                                                              usingQueue:self.internalQueue
                                                           launchHandler:^(__kindof BGSystemTask * _Nonnull task) {
        [self _onQueue_handleRecompute:task];
    }];
}

@end
