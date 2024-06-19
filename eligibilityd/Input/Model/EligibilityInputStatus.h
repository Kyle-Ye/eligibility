//
//  EligibilityInputStatus.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EligibilityInputStatus) {
    EligibilityInputStatusNone = 0,
    EligibilityInputStatusNotSet = 1,
    EligibilityInputStatusNotEligible = 2,
    EligibilityInputStatusEligible = 3,
    EligibilityInputStatusLibraryMax = 4,
    EligibilityInputStatusUnspecifiedError = 5,
    EligibilityInputStatusTokenExpired = 6,
    EligibilityInputStatusNoAccount = 7,
};

NSString * _Nullable eligibility_input_status_to_str(EligibilityInputStatus status);

NS_ASSUME_NONNULL_END
