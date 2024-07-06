//
//  EligibilityAnswer.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef EligibilityAnswer_h
#define EligibilityAnswer_h

#include "EligibilityBase.h"

typedef ELIGIBILITY_ENUM(uint64_t, EligibilityAnswer) {
    EligibilityAnswerInvalid = 0,
    EligibilityAnswerNotYetAvailable = 1,
    EligibilityAnswerNotEligible = 2,
    EligibilityAnswerMaybe = 3,
    EligibilityAnswerEligible = 4,
};

#endif /* EligibilityAnswer_h */
