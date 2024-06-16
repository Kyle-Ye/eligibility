//
//  Eligibility+Util.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "Eligibility+Util.h"
#import "EligibilityLog.h"
#import "EligibilityInputType.h"
#import "EligibilityInputStatus.h"

NSString * _Nullable eligibility_input_to_str(EligibilityInputType type) {
    switch (type) {
        case EligibilityInputTypeInvalid: return @"OS_ELIGIBILITY_INPUT_INVALID";
        case EligibilityInputTypeCountryLocation: return @"OS_ELIGIBILITY_INPUT_COUNTRY_LOCATION";
        case EligibilityInputTypeCountryBilling: return @"OS_ELIGIBILITY_INPUT_COUNTRY_BILLING";
        case EligibilityInputTypeDeviceClass: return @"OS_ELIGIBILITY_INPUT_DEVICE_CLASS";
        case EligibilityInputTypeDeviceLocale: return @"OS_ELIGIBILITY_INPUT_DEVICE_LOCALE";
        case EligibilityInputTypeChinaCellular: return @"OS_ELIGIBILITY_INPUT_CHINA_CELLULAR";
        case EligibilityInputTypeDeviceRegionCode: return @"OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE";
        case EligibilityInputTypeDeviceLanguage: return @"OS_ELIGIBILITY_INPUT_DEVICE_LANGUAGE";
        case EligibilityInputTypeGenerativeModelSystem: return @"OS_ELIGIBILITY_INPUT_GENERATIVE_MODEL_SYSTEM";
        case EligibilityInputTypeGreyMatterOnQueue: return @"OS_ELIGIBILITY_INPUT_GREYMATTER_ON_QUEUE";
        case EligibilityInputTypeSiriLanguage: return @"OS_ELIGIBILITY_INPUT_SIRI_LANGUAGE";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported input type: %llu", "eligibility_input_to_str", (unsigned long long)type);
            return nil;
    }
}

NSString * _Nullable eligibility_input_status_to_str(EligibilityInputStatus status) {
    switch (status) {
        case EligibilityInputStatusNone: return @"OS_ELIGIBILITY_INPUT_STATUS_NONE";
        case EligibilityInputStatusNotSet: return @"OS_ELIGIBILITY_INPUT_STATUS_NOT_SET";
        case EligibilityInputStatusNotEligible: return @"OS_ELIGIBILITY_INPUT_STATUS_NOT_ELIGIBLE";
        case EligibilityInputStatusEligible: return @"OS_ELIGIBILITY_INPUT_STATUS_ELIGIBLE";
        case EligibilityInputStatusLibraryMax: return @"OS_ELIGIBILITY_INPUT_STATUS_LIBRARY_MAX";
        case EligibilityInputStatusUnspecifiedError: return @"OS_ELIGIBILITY_INPUT_STATUS_UNSPECIFIED_ERROR";
        case EligibilityInputStatusTokenExpired: return @"OS_ELIGIBILITY_INPUT_STATUS_TOKEN_EXPIRED";
        case EligibilityInputStatusNoAccount: return @"OS_ELIGIBILITY_INPUT_STATUS_NO_ACCOUNT";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported input status: %llu", "eligibility_input_status_to_str", (unsigned long long) status);
            break;
    }
    return nil;
}
