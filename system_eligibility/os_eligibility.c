//
//  os_eligibility.c
//  eligibility
//
//  Created by Kyle on 2024/7/2.
//  Audited for RELEASE_2024_BETA_1
//  Status: WIP

#include "os_eligibility.h"
#include "eligibility_plist.h"
#include "eligibility_xpc.h"
#include "eligibility_log_handle.h"
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

// TODO: Add more cases
const char * os_eligibility_get_domain_notification_name(EligibilityDomainType domain) {
    switch (domain) {
        case EligibilityDomainTypeTest: return "com.apple.os-eligibility-domain.change.test";
        case EligibilityDomainTypeXcodeLLM: return "com.apple.os-eligibility-domain.change.xcode-llm";
        default:
            os_log_error(eligibility_log_handle(), "%s: Unable to convert domain to notification string: %llu", __func__, domain);
            return nil;
    }
}

int os_eligibility_set_input(EligibilityInputType input, xpc_object_t value, EligibilityInputStatus status) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeSetInput, message);
    xpc_dictionary_set_uint64(message, "input", input);
    if (value) {
        xpc_dictionary_set_value(message, "value", value);
    }
    xpc_dictionary_set_uint64(message, "status", status);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_reset_domain(EligibilityDomainType domain) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeResetDomain, message);
    xpc_dictionary_set_uint64(message, "domain", domain);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_force_domain_answer(EligibilityDomainType domain, EligibilityAnswer answer, xpc_object_t context) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(ELIGIBILITYXPCMessageTypeForceDomainAnswer, message);
    xpc_dictionary_set_uint64(message, "domain", domain);
    xpc_dictionary_set_uint64(message, "answer", answer);
    if (context) {
        xpc_dictionary_set_value(message, "context", context);
    }
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_get_internal_state(xpc_object_t* internal_state_ptr) {
    if (internal_state_ptr == NULL) {
        return EINVAL;
    }
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(ELIGIBILITYXPCMessageTypeGetInternalState, message);
    xpc_object_t reply = NULL;
    int error_num = eligibility_xpc_send_message_with_reply(message, &reply);
    if (error_num == 0) {
        xpc_object_t internal_state = xpc_dictionary_get_dictionary(reply, "internalState");
        if (internal_state) {
            xpc_retain(internal_state);
        }
        *internal_state_ptr = internal_state;
    }
    if (reply) {
        xpc_release(reply);
    }
    xpc_release(message);
    return error_num;
}

int os_eligibility_reset_all_domains(void) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeResetAllDomains, message);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_force_domain_set_answers(EligibilityDomainTypes domainSet, EligibilityAnswer answer, xpc_object_t context) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(ELIGIBILITYXPCMessageTypeForceDomainSetAnswer, message);
    xpc_dictionary_set_uint64(message, "domainSet", domainSet);
    xpc_dictionary_set_uint64(message, "answer", answer);
    if (context) {
        xpc_dictionary_set_value(message, "context", context);
    }
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_get_state_dump(xpc_object_t* state_dump_dictionary_ptr) {
    if (state_dump_dictionary_ptr == NULL) {
        return EINVAL;
    }
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeGetStateDump, message);
    xpc_object_t reply = NULL;
    int error_num = eligibility_xpc_send_message_with_reply(message, &reply);
    if (error_num == 0) {
        xpc_object_t state_dump_dictionary = xpc_dictionary_get_dictionary(reply, "stateDumpDictionary");
        if (state_dump_dictionary) {
            xpc_retain(state_dump_dictionary);
        }
        *state_dump_dictionary_ptr = state_dump_dictionary;
    }
    if (reply) {
        xpc_release(reply);
    }
    xpc_release(message);
    return error_num;
}

int os_eligibility_dump_sysdiagnose_data_to_dir(const char* dir_path) {
    if (dir_path == NULL) {
        return EINVAL;
    }
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeDumpSysdiagnoseData, message);
    xpc_dictionary_set_string(message, "dirPath", dir_path);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;    
}

int os_eligibility_set_test_mode(bool enabled) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeSetTestMode, message);
    xpc_dictionary_set_bool(message, "enabled", enabled);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_get_domain_answer(EligibilityDomainType domain, EligibilityAnswer *arg1, xpc_object_t arg2, xpc_object_t * arg3, void * arg4) {
    os_log_info(eligibility_log_handle(), "%s: TODO Umplementated yet", __func__);
    return 0;
}

int os_eligibility_get_all_domain_answers(xpc_object_t *answers_ptr) {
    xpc_object_t dictionary = xpc_dictionary_create(NULL, NULL, 0);
    const char *answer_path = copy_eligibility_domain_answer_plist_path();
    const char *public_answer_path = copy_eligibility_domain_public_answer_plist_path();
    int error_num = _append_plist_keys_to_dictionary(answer_path, dictionary);
    if (error_num != 0) {
        os_log_info(eligibility_log_handle(), "%s: Failed to load in plist %s: error=%d", __func__, answer_path, error_num);
        dictionary = NULL;
    } else {
        error_num = _append_plist_keys_to_dictionary(public_answer_path, dictionary);
        if (error_num != 0) {
            os_log_info(eligibility_log_handle(), "%s: Failed to load in plist %s: error=%d", __func__, public_answer_path, error_num);
            dictionary = NULL;
        }
    }
    free((void *)answer_path);
    free((void *)public_answer_path);
    if (answers_ptr) {
        *answers_ptr = dictionary;
    }
    // FIXME: A potiential memory leak on dictionry. We should retain or release dictionary here
    return error_num;
}
