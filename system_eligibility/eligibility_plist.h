//
//  eligibility_plist.h
//  system_eligibility
//
//  Created by Kyle on 2024/7/6.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef eligibility_plist_h
#define eligibility_plist_h

#include "EligibilityBase.h"
#include <xpc/xpc.h>

const char * copy_eligibility_domain_answer_plist_path(void);
const char * copy_eligibility_domain_public_answer_plist_path(void);
ELIGIBILITY_EXPORT
int load_eligibility_plist(const char *path, xpc_object_t *result_ptr);
int _append_plist_keys_to_dictionary(const char *path, xpc_object_t dictionary);

#endif /* eligibility_plist_h */
