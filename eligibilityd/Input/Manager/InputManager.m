//
//  InputManager.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "InputManager.h"
#import "LocatedCountryInput.h"
#import "CountryBillingInput.h"
#import "DeviceClassInput.h"
#import "DeviceLocaleInput.h"
#import "ChinaCellularInput.h"
#import "DeviceRegionCodeInput.h"
#import "DeviceLanguageInput.h"
#import "GenerativeModelSystemInput.h"
#import "GreymatterQueueInput.h"
#import "SiriLanguageInput.h"
#import "EligibilityLog.h"
#import "EligibilityUtils.h"

@interface InputManager ()
- (NSDictionary *)_createDefaultInputs;
- (BOOL)_saveInputsWithError:(NSError * _Nullable *)errorPtr;
- (NSDictionary *)_loadInputsWithError:(NSError * _Nullable *)errorPtr;
@end

@implementation InputManager

+ (instancetype)sharedInstance {
    static InputManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[InputManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableDictionary *defaultInputs = [self _createDefaultInputs].mutableCopy;
        NSError *error = nil;
        NSDictionary * inputs = [self _loadInputsWithError:&error];
        if (!inputs) {
            os_log_error(eligibility_log(), "%s: Unable to load inputs from disk, initing with empty values: %@", __FUNCTION__, error);
        } else {
            [defaultInputs addEntriesFromDictionary:inputs];
        }
        self.eligibilityInputs = defaultInputs.copy;
    }
    return self;
}

- (NSDictionary *)debugDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [self.eligibilityInputs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        dict[key] = [obj description];
    }];
    return dict.copy;
}

- (NSDictionary *)_createDefaultInputs {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    LocatedCountryInput *locatedCountryInput = [[LocatedCountryInput alloc] initWithCountryCodes:nil status:EligibilityInputStatusNotSet process:nil];
    if (locatedCountryInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeCountryLocation)] = locatedCountryInput;
    }
    
    CountryBillingInput *countryBillingInput = [[CountryBillingInput alloc] initWithBillingCountry:nil status:EligibilityInputStatusNotSet process:nil];
    if (countryBillingInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeCountryBilling)] = countryBillingInput;
    }
    
    DeviceClassInput *deviceClassInput = [[DeviceClassInput alloc] init];
    if (deviceClassInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeDeviceClass)] = deviceClassInput;
    }
    
    DeviceLocaleInput *deviceLocaleInput = [[DeviceLocaleInput alloc] initWithDeviceLocale:nil status:EligibilityInputStatusNotSet process:nil];
    if (deviceLocaleInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeDeviceLocale)] = deviceLocaleInput;
    }
    
    ChinaCellularInput *chinaCellularInput = [[ChinaCellularInput alloc] init];
    if (chinaCellularInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeChinaCellular)] = chinaCellularInput;
    }
    
    DeviceRegionCodeInput *deviceRegionCodeInput = [[DeviceRegionCodeInput alloc] init];
    if (deviceRegionCodeInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeDeviceRegionCode)] = deviceRegionCodeInput;
    }
    
    DeviceLanguageInput *deviceLanguageInput = [[DeviceLanguageInput alloc] init];
    if (deviceLanguageInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeDeviceLanguage)] = deviceLanguageInput;
    }
    
    GenerativeModelSystemInput *generativeModelSystemInput = [[GenerativeModelSystemInput alloc] init];
    if (generativeModelSystemInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeGenerativeModelSystem)] = generativeModelSystemInput;
    }
    
    GreymatterQueueInput *greymatterQueueInput = [[GreymatterQueueInput alloc] initOnQueue:nil status:EligibilityInputStatusNotSet process:nil];
    if (greymatterQueueInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeGreyMatterOnQueue)] = greymatterQueueInput;
    }
    
    SiriLanguageInput *siriLanguageInput = [[SiriLanguageInput alloc] init];
    if (siriLanguageInput) {
        dict[eligibility_input_to_NSString(EligibilityInputTypeSiriLanguage)] = siriLanguageInput;
    }
    
    return dict.copy;
}

- (BOOL)_saveInputsWithError:(NSError * _Nullable *)errorPtr {
    const char *path = copy_eligibility_domain_input_manager_plist_path();
    if (!path) {
        os_log_error(eligibility_log(), "%s: Failed to copy input manager plist path", __FUNCTION__);
        free((void *)path);
        if (errorPtr) {
            *errorPtr = nil;
        }
        return NO;
    }
    NSString *pathString = [NSString stringWithUTF8String:path];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:YES];
    [archiver encodeObject:self.eligibilityInputs forKey:NSKeyedArchiveRootObjectKey];
    NSData *encodedData = [archiver encodedData];
    NSURL *pathURL = [NSURL fileURLWithPath:pathString isDirectory:NO];
    NSError *writingError = nil;
    BOOL result = [encodedData writeToURL:pathURL options:NSDataWritingAtomic | NSDataWritingFileProtectionNone error:&writingError];
    if (!result) {
        os_log_error(eligibility_log(), "%s: Failed to write eligibility data %@ to disk at %@: %@", __FUNCTION__, self.eligibilityInputs, pathURL, writingError);
        free((void *)path);
        if (errorPtr) {
            *errorPtr = writingError;
        }
        return NO;
    }
    free((void *)path);
    return YES;
}

- (NSDictionary *)_loadInputsWithError:(NSError * _Nullable *)errorPtr {
    NSSet *supportedClasses = [NSSet setWithObjects:NSDictionary.class, EligibilityInput.class, NSString.class, nil];
    const char *path = copy_eligibility_domain_input_manager_plist_path();
    NSDictionary * inputs = nil;
    NSError *error = nil;
    if (!path) {
        os_log_error(eligibility_log(), "%s: Failed to copy input manager plist path", __FUNCTION__);
    } else {
        NSString *pathString = [NSString stringWithUTF8String:path];
        NSURL *pathURL = [NSURL fileURLWithPath:pathString isDirectory:NO];
        NSError *readingError = nil;
        NSData *data = [NSData dataWithContentsOfURL:pathURL options:NSDataReadingMappedIfSafe | NSDataReadingUncached error:&readingError];
        if (!data) {
            os_log_error(eligibility_log(), "%s: Failed to deserialize data in %@: %@", __FUNCTION__, pathURL.path, readingError);
            error = readingError;
        } else {
            NSError *unarchiveError = nil;
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&unarchiveError];
            if (!unarchiver) {
                os_log_error(eligibility_log(), "%s: Failed to create unarchiver: %@", __FUNCTION__, unarchiveError);
                error = unarchiveError;
            } else {
                id decoded = [unarchiver decodeObjectOfClasses:supportedClasses forKey:NSKeyedArchiveRootObjectKey];
                if (!decoded) {
                    os_log_error(eligibility_log(), "%s: Failed to decode input from data at %@ : %@", __FUNCTION__, pathURL.path, unarchiver.error);
                    error = unarchiver.error;
                } else {
                    [unarchiver finishDecoding];
                    inputs = decoded;
                }
            }
        }
    }
    free((void *)path);
    if (errorPtr && !inputs) {
        *errorPtr = error;
    }
    return inputs;
}

- (BOOL)setInput:(EligibilityInput *)input withError:(NSError * _Nullable *)errorPtr {
    const char *inputTypeStr = eligibility_input_to_str(input.type);
    if (!inputTypeStr) {
        os_log_error(eligibility_log(), "%s: Unknown input %@", __FUNCTION__, input);
        if (errorPtr) {
            *errorPtr = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
        }
        return NO;
    }
    NSString *inputTypeString = [NSString stringWithUTF8String:inputTypeStr];
    NSMutableDictionary *eligibilityInputs = self.eligibilityInputs.mutableCopy;
    eligibilityInputs[inputTypeString] = input;
    self.eligibilityInputs = eligibilityInputs.copy;
    return [self _saveInputsWithError:errorPtr];
}

- (EligibilityInput *)objectForInputValue:(EligibilityInputType)inputType {
    const char *inputTypeStr = eligibility_input_to_str(inputType);
    if (!inputTypeStr) {
        os_log_error(eligibility_log(), "%s: Unknown input %llu", __FUNCTION__, (uint64_t)inputType);
        return nil;
    }
    NSString *inputTypeString = [NSString stringWithUTF8String:inputTypeStr];
    return self.eligibilityInputs[inputTypeString];
}

@end
 
