//
//  EligibilityDomainSet.h
//  eligibility
//
//  Created by Kyle on 2024/7/6.
//

#ifndef EligibilityDomainSet_h
#define EligibilityDomainSet_h

#include "EligibilityBase.h"
#include "EligibilityDomainType.h"

typedef ELIGIBILITY_ENUM(uint64_t, EligibilityDomainSet) {
    EligibilityDomainSetInvalid = 0,
    EligibilityDomainSetDefault = 1,
};

#endif /* EligibilityDomainSet_h */
