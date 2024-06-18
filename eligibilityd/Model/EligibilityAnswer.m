//
//  EligibilityAnswer.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//

#import "EligibilityAnswer.h"
#import "EligibilityLog.h"

NSString *eligibility_answer_to_str(EligibilityAnswer answer) {
    switch (answer) {
        case EligibilityAnswerInvalid: return @"OS_ELIGIBILITY_ANSWER_INVALID";
        case EligibilityAnswerNotYetAvailable: return @"OS_ELIGIBILITY_ANSWER_NOT_YET_AVAILABLE";
        case EligibilityAnswerNotEligible: return @"OS_ELIGIBILITY_ANSWER_NOT_ELIGIBLE";
        case EligibilityAnswerMaybe: return @"OS_ELIGIBILITY_ANSWER_MAYBE";
        case EligibilityAnswerEligible: return @"OS_ELIGIBILITY_ANSWER_ELIGIBLE";
        default:
            os_log_error(eligibility_log(), "%s: Unsupported answer type: %llu", "eligibility_answer_to_str", (unsigned long long)answer);
            return nil;
    }
}
