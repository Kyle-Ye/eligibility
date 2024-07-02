//
//  EligibilityDomainType.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/24.
//

#ifndef EligibilityDomainType_h
#define EligibilityDomainType_h

#include <Foundation/Foundation.h>

#define EligibilityDomainTypeCount 124

// TODO
typedef NS_ENUM(NSUInteger, EligibilityDomainType) {
    EligibilityDomainTypeInvalid = 0,
    EligibilityDomainTypeTest = 120,
    EligibilityDomainTypeXcodeLLM = 123,
};

#endif /* EligibilityDomainType_h */
