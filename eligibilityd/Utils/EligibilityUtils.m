//
//  EligibilityUtils.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import "EligibilityUtils.h"
#import "EligibilityLog.h"
#import "XPCSPI.h"

void asyncBlock(dispatch_queue_t queue, dispatch_block_t block) {
    // TODO
    os_transaction_t transaction = os_transaction_create("com.apple.eligibilityd.async-block");
    
    dispatch_async(queue, ^{
        @autoreleasepool {
            block();
        }
    });
}

const char *copy_eligibility_domain_daemon_directory_path(void) {
    char *buffer;
    int size = asprintf(&buffer, "%s%s", "/", "/private/var/db/eligibilityd/eligibility_inputs.plist");
    if (size == -1) {
        os_log_error(eligibility_log(), "%s: Failed to construct absolute path for relative path: %s", __FUNCTION__, "/private/var/db/os_eligibility");
    }
    return buffer;
}

uint64_t eligibility_xpc_get_message_type(xpc_object_t object) {
    xpc_type_t type = xpc_get_type(object);
    if (type != XPC_TYPE_DICTIONARY) {
        os_log_error(eligibility_log(), "%s: xpc message type must be a dictionary", __func__);
        return 0;
    }
    return xpc_dictionary_get_uint64(object, "eligibility_message_type");
}
