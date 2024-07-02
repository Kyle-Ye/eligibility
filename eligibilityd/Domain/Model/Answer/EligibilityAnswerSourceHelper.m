//
//  EligibilityAnswerSourceHelper.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/18.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityAnswerSourceHelper.h"
#import "EligibilityLog.h"

const char * _Nullable eligibility_answer_source_to_str(EligibilityAnswerSource answerSource) {
    switch (answerSource) {
        case EligibilityAnswerSourceInvalid: return "OS_ELIGIBILITY_ANSWER_SOURCE_INVALID";
        case EligibilityAnswerSourceComputed: return "OS_ELIGIBILITY_ANSWER_SOURCE_COMPUTED";
        case EligibilityAnswerSourceForced: return "OS_ELIGIBILITY_ANSWER_SOURCE_FORCED";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported answer source: %llu", __func__, (uint64_t)answerSource);
            return nil;
    }
}

NSString *eligibility_answer_source_to_NSString(EligibilityAnswerSource answerSource) {
    const char *str = eligibility_answer_source_to_str(answerSource);
    return str ? [NSString stringWithUTF8String:str] : [NSString stringWithFormat:@"<Unknown: %llu>", (uint64_t)answerSource];
}
