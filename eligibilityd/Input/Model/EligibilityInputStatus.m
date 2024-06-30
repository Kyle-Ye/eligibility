//
//  EligibilityInputStatus.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityInputStatus.h"
#import "EligibilityLog.h"

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
            os_log_error(eligibility_log(), "%s: Unsupported input status: %llu", __func__, (uint64_t) status);
            return nil;
    }
}
