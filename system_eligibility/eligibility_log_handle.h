//
//  eligibility_log_handle.h
//  system_eligibility
//
//  Created by Kyle on 2024/7/3.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef eligibility_log_handle_h
#define eligibility_log_handle_h

#include <dispatch/dispatch.h>
#include <os/log.h>
#include "EligibilityBase.h"

ELIGIBILITY_INLINE
os_log_t eligibility_log_handle(void) {
    static dispatch_once_t once_token;
    static os_log_t log_handle;
    dispatch_once(&once_token, ^{
        log_handle = os_log_create("com.apple.os_eligibility", "library");
    });
    return log_handle;
}
                
#endif /* eligibility_log_handle_h */
