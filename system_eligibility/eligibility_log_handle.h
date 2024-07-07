//
//  eligibility_log_handle.h
//  system_eligibility
//
//  Created by Kyle on 2024/7/3.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef eligibility_log_handle_h
#define eligibility_log_handle_h

#include "EligibilityBase.h"

#include <dispatch/dispatch.h>
#include <os/log.h>

os_log_t eligibility_log_handle(void);

#endif /* eligibility_log_handle_h */
