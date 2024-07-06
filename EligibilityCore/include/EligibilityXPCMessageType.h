//
//  EligibilityXPCMessageType.h
//  EligibilityCore
//
//  Created by Kyle on 2024/7/3.
//  Audited for RELEASE_2024_BETA_1
//  Status: WIP

#ifndef EligibilityXPCMessageType_h
#define EligibilityXPCMessageType_h

#include "EligbilityBase.h"

typedef ELIGIBILITY_ENUM(uint64_t, EligibilityXPCMessageType) {
    EligibilityXPCMessageTypeInvalid = 0,
    EligibilityXPCMessageTypeResetDomain = 2,
    EligibilityXPCMessageTypeResetAllDomains = 5,
    EligibilityXPCMessageTypeSetTestMode = 9,
};

#endif /* EligibilityXPCMessageType_h */



