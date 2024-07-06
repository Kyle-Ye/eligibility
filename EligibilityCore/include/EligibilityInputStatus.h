//
//  EligibilityInputStatus.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef EligibilityInputStatus_h
#define EligibilityInputStatus_h

#include "EligbilityBase.h"

typedef ELIGIBILITY_ENUM(uint64_t, EligibilityInputStatus) {
    EligibilityInputStatusNone = 0,
    EligibilityInputStatusNotSet = 1,
    EligibilityInputStatusNotEligible = 2,
    EligibilityInputStatusEligible = 3,
    EligibilityInputStatusLibraryMax = 4,
    EligibilityInputStatusUnspecifiedError = 5,
    EligibilityInputStatusTokenExpired = 6,
    EligibilityInputStatusNoAccount = 7,
};
#endif /* EligibilityInputStatus_h */
