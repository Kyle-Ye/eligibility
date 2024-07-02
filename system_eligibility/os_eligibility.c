//
//  os_eligibility.c
//  eligibility
//
//  Created by Kyle on 2024/7/2.
//

#include "os_eligibility.h"
#include "xpc/xpc.h"

// TODO: Add more cases
EligibilityDomainType os_eligibility_domain_for_name(const char *name) {
    if (!name) {
        return EligibilityDomainTypeInvalid;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_INVALID") == 0) {
        return EligibilityDomainTypeInvalid;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TEST") == 0) {
        return EligibilityDomainTypeTest;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_XCODE_LLM") == 0) {
        return EligibilityDomainTypeXcodeLLM;
    } else {
        return EligibilityDomainTypeInvalid;
    }
}

void os_eligibility_reset_domain(const char *domain) {
    // TODO
}

void os_eligibility_reset_all_domains(void) {
    // TODO
}
