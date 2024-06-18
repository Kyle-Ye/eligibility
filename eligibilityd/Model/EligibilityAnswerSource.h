//
//  EligibilityAnswerSource.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/18.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EligibilityAnswerSource) {
    EligibilityAnswerSourceInvalid = 0,
    EligibilityAnswerSourceComputed = 1,
    EligibilityAnswerSourceForced = 2,
};

NSString *eligibility_answer_source_to_str(EligibilityAnswerSource answerSource);

NS_ASSUME_NONNULL_END
