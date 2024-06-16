//
//  EligibilityLog.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import "Log.h"

os_log_t eligibility_log(void) {
    static dispatch_once_t onceToken;
    static os_log_t log = NULL;
    dispatch_once(&onceToken, ^{
        log = os_log_create("com.apple.os_eligibility", "daemon");
    });
    return log;
}
