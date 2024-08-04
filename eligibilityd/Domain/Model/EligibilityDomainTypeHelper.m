//
//  EligibilityDomainTypeHelper.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import "EligibilityDomainTypeHelper.h"
#import "EligibilityUtils.h"

NSString *eligibility_domain_to_NSString(EligibilityDomainType domain) {
    return [NSString stringWithUTF8String:eligibility_domain_to_str(domain)];
}

const char *eligibility_plist_path_for_domain(EligibilityDomainType domain) {
    const char *plist_path;
    switch (domain) {
        case EligibilityDomainTypeLotX ... EligibilityDomainTypePotassium:
        case EligibilityDomainTypeScandium ... EligibilityDomainTypePodcastsTranscripts:
        case EligibilityDomainTypeXcodeLLM:
        case EligibilityDomainTypeSearchMarketplaces:
            plist_path = copy_eligibility_domain_answer_plist_path();
            break;
        case EligibilityDomainTypeCalcium:
        case EligibilityDomainTypeGreymatter:
            plist_path = copy_eligibility_domain_public_answer_plist_path();
            break;
        default:
            plist_path = NULL;
            break;
    }
    return plist_path;
}
