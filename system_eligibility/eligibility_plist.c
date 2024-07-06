//
//  eligibility_plist.c
//  system_eligibility
//
//  Created by Kyle on 2024/7/6.
//

#include "eligibility_plist.h"
#include "eligibility_log_handle.h"

const char * copy_eligibility_domain_answer_plist_path(void) {
    char *buffer;
    int size = asprintf(&buffer, "%s%s", "/", "/private/var/db/os_eligibility/eligibility.plist");
    if (size == -1) {
        os_log_error(eligibility_log_handle(), "%s: Failed to construct absolute path for relative path: %s", __func__, "/private/var/db/os_eligibility/eligibility.plist");
    }
    return buffer;
}

const char * copy_eligibility_domain_public_answer_plist_path(void) {
    char *buffer;
    int size = asprintf(&buffer, "%s%s", "/", "/private/var/db/eligibilityd/eligibility.plist");
    if (size == -1) {
        os_log_error(eligibility_log_handle(), "%s: Failed to construct absolute path for relative path: %s", __func__, "/private/var/db/eligibilityd/eligibility.plist");
    }
    return buffer;
}

// TODO
void load_eligibility_plist(void) {
    
}

int _append_plist_keys_to_dictionary(const char *, xpc_object_t) {
    return 0;
}
