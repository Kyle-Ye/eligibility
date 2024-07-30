//
//  EligibilityInputTypes.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef EligibilityInputTypes_h
#define EligibilityInputTypes_h

#include "EligibilityBase.h"
#include "EligibilityInputType.h"

typedef ELIGIBILITY_OPTIONS(uint64_t, EligibilityInputTypes) {
    EligibilityInputTypesInvalid = EligibilityInputTypeInvalid,
    EligibilityInputTypesCountryLocation = 1 << (EligibilityInputTypeCountryLocation - 1),
    EligibilityInputTypesCountryBilling = 1 << (EligibilityInputTypeCountryBilling - 1),
    EligibilityInputTypesDeviceClass = 1 << (EligibilityInputTypeDeviceClass - 1),
    EligibilityInputTypesDeviceLocale = 1 << (EligibilityInputTypeDeviceLocale - 1),
    EligibilityInputTypesChinaCellular = 1 << (EligibilityInputTypeChinaCellular - 1),
    EligibilityInputTypesDeviceRegionCode = 1 << (EligibilityInputTypeDeviceRegionCode - 1),
    EligibilityInputTypesDeviceLanguage = 1 << (EligibilityInputTypeDeviceLanguage - 1),
    EligibilityInputTypesGenerativeModelSystem = 1 << (EligibilityInputTypeGenerativeModelSystem - 1),
    EligibilityInputTypesGreyMatterOnQueue = 1 << (EligibilityInputTypeGreyMatterOnQueue - 1),
    EligibilityInputTypesSiriLanguage = 1 << (EligibilityInputTypeSiriLanguage - 1),
    EligibilityInputTypesExternalBoot = 1 << (EligibilityInputTypeExternalBoot - 1),
};

#endif /* EligibilityInputTypes_h */
