//
//  EligibilityLog.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityLog.h"

os_log_t eligibility_log(void) {
    static dispatch_once_t onceToken;
    static os_log_t log = NULL;
    dispatch_once(&onceToken, ^{
        log = os_log_create("com.apple.os_eligibility", "daemon");
    });
    return log;
}
