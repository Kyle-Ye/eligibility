//
//  EligibilityDomainType.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define EligibilityDomainTypeCount 124

// TODO
typedef NS_ENUM(NSUInteger, EligibilityDomainType) {
    EligibilityDomainTypeInvalid = 0,
    EligibilityDomainTypeTest = 120,
    EligibilityDomainTypeXcodeLLM = 123,
};

const char * eligibility_domain_to_str(EligibilityDomainType domain);
NSString *eligibility_domain_to_NSString(EligibilityDomainType domain);

NS_ASSUME_NONNULL_END
