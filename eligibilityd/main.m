//
//  main.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import <Foundation/Foundation.h>
#import "EligibilityLog.h"
#import "EligibilityBase.h"

int main(int argc, const char * argv[]) {
    os_log_info(eligibility_log(), "%s: eligibilityd (%s) built at %s %s started", __func__, VERSION, __DATE__, __TIME__);
    return 0;
}
