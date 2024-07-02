//
//  EligibilityAnswerSource.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/18.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef EligibilityAnswerSource_h
#define EligibilityAnswerSource_h

#include <CoreFoundation/CoreFoundation.h>

typedef CF_ENUM(uint64_t, EligibilityAnswerSource) {
    EligibilityAnswerSourceInvalid = 0,
    EligibilityAnswerSourceComputed = 1,
    EligibilityAnswerSourceForced = 2,
};

#endif /* EligibilityAnswerSource_h */
