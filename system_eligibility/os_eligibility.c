//
//  os_eligibility.c
//  eligibility
//
//  Created by Kyle on 2024/7/2.
//

#include "os_eligibility.h"
#include "eligibility_xpc.h"
#include <xpc/xpc.h>

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

void os_eligibility_reset_domain(EligibilityDomainType domain) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(message, EligibilityXPCMessageTypeResetDomain);
    xpc_dictionary_set_uint64(message, "domain", domain);
    eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
}

void os_eligibility_reset_all_domains(void) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(message, EligibilityXPCMessageTypeResetAllDomains);
    eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
}

void os_eligibility_set_test_mode(bool enabled) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(message, EligibilityXPCMessageTypeSetTestMode);
    xpc_dictionary_set_bool(message, "enabled", enabled);
    eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
}
