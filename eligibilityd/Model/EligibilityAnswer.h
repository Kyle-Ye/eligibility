//
//  EligibilityAnswer.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EligibilityAnswer) {
    EligibilityAnswerInvalid = 0,
    EligibilityAnswerNotYetAvailable = 1,
    EligibilityAnswerNotEligible = 2,
    EligibilityAnswerMaybe = 3,
    EligibilityAnswerEligible = 4,
};

NSString *eligibility_answer_to_str(EligibilityAnswer answer);

NS_ASSUME_NONNULL_END
