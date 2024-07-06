//
//  eligibility_plist.h
//  system_eligibility
//
//  Created by Kyle on 2024/7/6.
//

#ifndef eligibility_plist_h
#define eligibility_plist_h

#include "EligibilityBase.h"
#include <xpc/xpc.h>

const char * copy_eligibility_domain_answer_plist_path(void);
const char * copy_eligibility_domain_public_answer_plist_path(void);
void load_eligibility_plist(void);
int _append_plist_keys_to_dictionary(const char *, xpc_object_t);

#endif /* eligibility_plist_h */
