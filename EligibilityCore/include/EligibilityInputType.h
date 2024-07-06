//
//  EligibilityInputType.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef EligibilityInputType_h
#define EligibilityInputType_h

#include "EligbilityBase.h"

#define EligibilityInputTypeCount 10

typedef ELIGIBILITY_ENUM(uint64_t, EligibilityInputType) {
    EligibilityInputTypeInvalid = 0,
    EligibilityInputTypeCountryLocation = 1,
    EligibilityInputTypeCountryBilling = 2,
    EligibilityInputTypeDeviceClass = 3,
    EligibilityInputTypeDeviceLocale = 4,
    EligibilityInputTypeChinaCellular = 5,
    EligibilityInputTypeDeviceRegionCode = 6,
    EligibilityInputTypeDeviceLanguage = 7,
    EligibilityInputTypeGenerativeModelSystem = 8,
    EligibilityInputTypeGreyMatterOnQueue = 9,
    EligibilityInputTypeSiriLanguage = 10,
};

#endif /* EligibilityInputType_h */
