//
//  EligibilityAnswerHelper.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityAnswer.h"

NS_ASSUME_NONNULL_BEGIN

const char * _Nullable eligibility_answer_to_str(EligibilityAnswer answer);
NSString *eligibility_answer_to_NSString(EligibilityAnswer answer);

NS_ASSUME_NONNULL_END
