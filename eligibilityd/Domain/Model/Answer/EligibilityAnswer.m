//
//  EligibilityAnswer.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//

#import "EligibilityAnswer.h"
#import "EligibilityLog.h"

const char * _Nullable eligibility_answer_to_str(EligibilityAnswer answer) {
    switch (answer) {
        case EligibilityAnswerInvalid: return "OS_ELIGIBILITY_ANSWER_INVALID";
        case EligibilityAnswerNotYetAvailable: return "OS_ELIGIBILITY_ANSWER_NOT_YET_AVAILABLE";
        case EligibilityAnswerNotEligible: return "OS_ELIGIBILITY_ANSWER_NOT_ELIGIBLE";
        case EligibilityAnswerMaybe: return "OS_ELIGIBILITY_ANSWER_MAYBE";
        case EligibilityAnswerEligible: return "OS_ELIGIBILITY_ANSWER_ELIGIBLE";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported answer type: %llu", __func__, (uint64_t)answer);
            return nil;
    }
}

NSString *eligibility_answer_to_NSString(EligibilityAnswer answer) {
    const char *str = eligibility_answer_to_str(answer);
    return str ? [NSString stringWithUTF8String:str] : [NSString stringWithFormat:@"<Unknown: %llu>", (uint64_t)answer];
}
