//
//  EligibilityUtils.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import "EligibilityUtils.h"
#import "EligibilityLog.h"
#import "XPCSPI.h"
#import "containermanager.h"

void asyncBlock(dispatch_queue_t queue, dispatch_block_t block) {
    // TODO
    os_transaction_t transaction = os_transaction_create("com.apple.eligibilityd.async-block");
    
    dispatch_async(queue, ^{
        @autoreleasepool {
            block();
        }
    });
}

const char *copy_eligibility_domain_data_vault_directory_path(void) {
    char *buffer;
    int size = asprintf(&buffer, "%s%s", "/", "/private/var/db/os_eligibility");
    if (size == -1) {
        os_log_error(eligibility_log(), "%s: Failed to construct absolute path for relative path: %s", __FUNCTION__, "/private/var/db/os_eligibility");
    }
    return buffer;
}

const char *copy_eligibility_domain_daemon_directory_path(void) {
    char *buffer;
    int size = asprintf(&buffer, "%s%s", "/", "/private/var/db/eligibilityd");
    if (size == -1) {
        os_log_error(eligibility_log(), "%s: Failed to construct absolute path for relative path: %s", __FUNCTION__, "/private/var/db/eligibilityd");
    }
    return buffer;
}

const char *copy_eligibility_domain_input_manager_plist_path(void) {
    char *buffer;
    int size = asprintf(&buffer, "%s%s", "/", "/private/var/db/eligibilityd/eligibility_inputs.plist");
    if (size == -1) {
        os_log_error(eligibility_log(), "%s: Failed to construct absolute path for relative path: %s", __FUNCTION__, "/private/var/db/eligibilityd/eligibility_inputs.plist");
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

NSURL * _Nullable OEURLForContainerWithError(NSError * _Nullable *errorPtr) {
    void *query = container_query_create();
    NSError *error;
    NSURL *resultURL;
    if (!query) {
        os_log_error(eligibility_log(), "%s: Failed to create container query", __func__);
        error = nil;
        resultURL = nil;
    } else {
        container_query_set_class(query, 0xa);
        xpc_object_t identifier = xpc_string_create("com.apple.eligibilityd");
        container_query_set_identifiers(query, identifier);
        container_query_set_persona_unique_string(query, CONTAINER_PERSONA_PRIMARY);
        container_query_operation_set_flags(query, 0x3 | 0x100000000);
        void *container = container_query_get_single_result(query);
        if (!container) {
            void *lastError = container_query_get_last_error(query);
            const char *lastErrorDescription = container_error_copy_unlocalized_description(lastError);
            os_log_error(eligibility_log(), "%s: Failed to query container manager: %s", __func__, lastErrorDescription);
            free((void *)lastErrorDescription);
            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:container_error_get_posix_errno(lastError) userInfo:nil];
            resultURL = nil;
        } else {
            const char *path = container_get_path(container);
            if (!path) {
                os_log_error(eligibility_log(),"%s: Failed to read path from returned container", __func__);
                error = nil;
                resultURL = nil;
            } else {
                NSString *pathString = [NSString stringWithUTF8String:path];
                error = nil;
                resultURL = [NSURL fileURLWithPath:pathString isDirectory:YES];
            }
        }
    }
    container_query_free(query);
    if (errorPtr && !resultURL) {
        *errorPtr = error;
    }
    return resultURL;
}
