//
//  EligibilityDomainTypes.h
//  eligibility
//
//  Created by Kyle on 2024/7/6.
//

#ifndef EligibilityDomainTypes_h
#define EligibilityDomainTypes_h

#include "EligibilityBase.h"
#include "EligibilityDomainType.h"

// TODO
typedef ELIGIBILITY_OPTIONS(uint64_t, EligibilityDomainTypes) {
    EligibilityDomainTypesInvalid = EligibilityDomainTypeInvalid,
    EligibilityDomainTypesTest = 1 << (EligibilityDomainTypeTest - 1),
    EligibilityDomainTypesXcodeLLM = 1 << (EligibilityDomainTypeXcodeLLM - 1),
};

#endif /* EligibilityDomainTypes_h */
