//
//  EligibilityDomainTypeHelper.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import "EligibilityDomainTypeHelper.h"
#import "EligibilityUtils.h"

const char *eligibility_domain_to_str(EligibilityDomainType domain) {
    switch (domain) {
        case EligibilityDomainTypeInvalid: return "OS_ELIGIBILITY_DOMAIN_INVALID";
        // TODO
        case EligibilityDomainTypeTest: return "OS_ELIGIBILITY_DOMAIN_TEST";
        // TODO
        case EligibilityDomainTypeGreymatter: return "OS_ELIGIBILITY_DOMAIN_GREYMATTER";
        case EligibilityDomainTypeXcodeLLM: return "OS_ELIGIBILITY_DOMAIN_XCODE_LLM";
        default: return "<Unknown Domain>";
    }
}

NSString *eligibility_domain_to_NSString(EligibilityDomainType domain) {
    return [NSString stringWithUTF8String:eligibility_domain_to_str(domain)];
}

// TODO: Update to corresponding EligibilityDomainType
const char *eligibility_plist_path_for_domain(EligibilityDomainType domain) {
    const char *plist_path;
    switch (domain) {
        case 1 ... 20:
        case 22 ... 121:
        case 123 ... 124:
            plist_path = copy_eligibility_domain_answer_plist_path();
            break;
        case 21:
        case 122:
            plist_path = copy_eligibility_domain_public_answer_plist_path();
            break;
        default:
            plist_path = NULL;
            break;
    }
    return plist_path;
}
