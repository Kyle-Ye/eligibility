//
//  EligibilityDomainType.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import "EligibilityDomainType.h"

const char *eligibility_domain_to_str(EligibilityDomainType domain) {
    switch (domain) {
        case EligibilityDomainTypeInvalid: return "OS_ELIGIBILITY_DOMAIN_INVALID";
        // TODO
        case EligibilityDomainTypeTest: return "OS_ELIGIBILITY_DOMAIN_TEST";
        // TODO
        case EligibilityDomainTypeXcodeLLM: return "OS_ELIGIBILITY_DOMAIN_XCODE_LLM";
        default: return "<Unknown Domain>";
    }
}

NSString *eligibility_domain_to_NSString(EligibilityDomainType domain) {
    return [NSString stringWithUTF8String:eligibility_domain_to_str(domain)];
}
