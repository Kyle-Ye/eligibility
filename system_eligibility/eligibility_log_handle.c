//
//  eligibility_log_handle.c
//  system_eligibility
//
//  Created by Kyle on 2024/7/7.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#include "eligibility_log_handle.h"

os_log_t eligibility_log_handle(void) {
   static dispatch_once_t once_token;
   static os_log_t log_handle;
   dispatch_once(&once_token, ^{
       log_handle = os_log_create("com.apple.os_eligibility", "library");
   });
   return log_handle;
}
