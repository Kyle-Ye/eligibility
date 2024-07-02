//
//  EligibilityInputTypeHelper.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityInputTypeHelper.h"
#import "EligibilityLog.h"

const char * _Nullable eligibility_input_to_str(EligibilityInputType type) {
    switch (type) {
        case EligibilityInputTypeInvalid: return "OS_ELIGIBILITY_INPUT_INVALID";
        case EligibilityInputTypeCountryLocation: return "OS_ELIGIBILITY_INPUT_COUNTRY_LOCATION";
        case EligibilityInputTypeCountryBilling: return "OS_ELIGIBILITY_INPUT_COUNTRY_BILLING";
        case EligibilityInputTypeDeviceClass: return "OS_ELIGIBILITY_INPUT_DEVICE_CLASS";
        case EligibilityInputTypeDeviceLocale: return "OS_ELIGIBILITY_INPUT_DEVICE_LOCALE";
        case EligibilityInputTypeChinaCellular: return "OS_ELIGIBILITY_INPUT_CHINA_CELLULAR";
        case EligibilityInputTypeDeviceRegionCode: return "OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE";
        case EligibilityInputTypeDeviceLanguage: return "OS_ELIGIBILITY_INPUT_DEVICE_LANGUAGE";
        case EligibilityInputTypeGenerativeModelSystem: return "OS_ELIGIBILITY_INPUT_GENERATIVE_MODEL_SYSTEM";
        case EligibilityInputTypeGreyMatterOnQueue: return "OS_ELIGIBILITY_INPUT_GREYMATTER_ON_QUEUE";
        case EligibilityInputTypeSiriLanguage: return "OS_ELIGIBILITY_INPUT_SIRI_LANGUAGE";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported input type: %llu", __func__, (uint64_t)type);
            return nil;
    }
}

NSString *eligibility_input_to_NSString(EligibilityInputType type) {
    const char *str = eligibility_input_to_str(type);
    return str ? [NSString stringWithUTF8String:str] : [NSString stringWithFormat:@"<Unknown: %llu>", (uint64_t)type];
}
