//
//  Eligibility+Util.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import "Eligibility+Util.h"
#import "EligibilityLog.h"

NSString * _Nullable eligibility_input_to_str(NSUInteger type) {
    switch (type) {
        case 0: return @"OS_ELIGIBILITY_INPUT_INVALID";
        case 1: return @"OS_ELIGIBILITY_INPUT_COUNTRY_LOCATION";
        case 2: return @"OS_ELIGIBILITY_INPUT_COUNTRY_BILLING";
        case 3: return @"OS_ELIGIBILITY_INPUT_DEVICE_CLASS";
        case 4: return @"OS_ELIGIBILITY_INPUT_DEVICE_LOCALE";
        case 5: return @"OS_ELIGIBILITY_INPUT_CHINA_CELLULAR";
        case 6: return @"OS_ELIGIBILITY_INPUT_DEVICE_REGION_CODE";
        case 7: return @"OS_ELIGIBILITY_INPUT_DEVICE_LANGUAGE";
        case 8: return @"OS_ELIGIBILITY_INPUT_GENERATIVE_MODEL_SYSTEM";
        case 9: return @"OS_ELIGIBILITY_INPUT_GREYMATTER_ON_QUEUE";
        case 10: return @"OS_ELIGIBILITY_INPUT_SIRI_LANGUAGE";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported input type: %llu", "eligibility_input_to_str", (unsigned long long)type);
            return nil;
    }
}

NSString * _Nullable eligibility_input_status_to_str(NSUInteger status) {
    switch (status) {
        case 0: return @"OS_ELIGIBILITY_INPUT_STATUS_NONE";
        case 1: return @"OS_ELIGIBILITY_INPUT_STATUS_NOT_SET";
        case 2: return @"OS_ELIGIBILITY_INPUT_STATUS_NOT_ELIGIBLE";
        case 3: return @"OS_ELIGIBILITY_INPUT_STATUS_ELIGIBLE";
        case 4: return @"OS_ELIGIBILITY_INPUT_STATUS_LIBRARY_MAX";
        case 5: return @"OS_ELIGIBILITY_INPUT_STATUS_UNSPECIFIED_ERROR";
        case 6: return @"OS_ELIGIBILITY_INPUT_STATUS_TOKEN_EXPIRED";
        case 7: return @"OS_ELIGIBILITY_INPUT_STATUS_NO_ACCOUNT";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported input status: %llu", "eligibility_input_status_to_str", (unsigned long long) status);
            break;
    }
    return nil;
}
