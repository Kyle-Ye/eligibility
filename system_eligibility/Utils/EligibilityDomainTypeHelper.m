//
//  EligibilityDomainTypeHelper.m
//  system_eligibility
//
//  Created by Kyle on 2024/6/24.
//

#include "EligibilityDomainTypeHelper.h"
#include "eligibility_plist.h"

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
