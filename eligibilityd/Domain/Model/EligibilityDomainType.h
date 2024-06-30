//
//  EligibilityDomainType.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define EligibilityDomainTypeCount 124

typedef NS_ENUM(NSUInteger, EligibilityDomainType) {
    EligibilityDomainTypeXcodeLLM = 123,
};

const char * eligibility_domain_to_str(EligibilityDomainType domain);

NS_ASSUME_NONNULL_END
