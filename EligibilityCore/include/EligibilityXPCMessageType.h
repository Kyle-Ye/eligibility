//
//  EligibilityXPCMessageType.h
//  EligibilityCore
//
//  Created by Kyle on 2024/7/3.
//  Audited for RELEASE_2024_BETA_1
//  Status: WIP

#ifndef EligibilityXPCMessageType_h
#define EligibilityXPCMessageType_h

#include "EligibilityBase.h"

typedef ELIGIBILITY_ENUM(uint64_t, EligibilityXPCMessageType) {
    EligibilityXPCMessageTypeInvalid = 0,
    EligibilityXPCMessageTypeSetInput = 1,
    EligibilityXPCMessageTypeResetDomain = 2,
    ELIGIBILITYXPCMessageTypeForceDomainAnswer = 3,
    ELIGIBILITYXPCMessageTypeGetInternalState = 4,
    EligibilityXPCMessageTypeResetAllDomains = 5,
    ELIGIBILITYXPCMessageTypeForceDomainSetAnswer = 6,
    EligibilityXPCMessageTypeGetStateDump = 7,
    EligibilityXPCMessageTypeDumpSysdiagnoseData = 8,
    EligibilityXPCMessageTypeSetTestMode = 9,
};

#endif /* EligibilityXPCMessageType_h */



