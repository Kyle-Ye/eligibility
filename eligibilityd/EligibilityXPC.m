//
//  EligibilityXPC.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//

#import "EligibilityXPC.h"
#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "XPCSPI.h"
#import "GlobalConfiguration.h"

#import <objc/objc.h>
#import <notify.h>
#import <libproc.h>

void asyncBlock(dispatch_queue_t queue, dispatch_block_t block);
void _sendInputsNeededNotification(void);
void _createDirectoryAtPath(void);
void copy_eligibility_domain_daemon_directory_path(void);

void _connectionHandler(xpc_object_t object, xpc_connection_t connection);
uint64_t eligibility_xpc_get_message_type(xpc_object_t object);
bool _checkEntitlement(void);
void _tryExitWhenCleanOnWorkloop_block_invoke(void);

static dispatch_source_t source;

// TODO
void main_block_invoke_1(void) {
    // TODO
    _sendInputsNeededNotification();
    copy_eligibility_domain_daemon_directory_path();
}

void main_block_invoke_2(xpc_object_t object) {
    const char * name = xpc_dictionary_get_string(object, _xpc_event_key_name);
    os_log(eligibility_log(), "%s: Got darwin notification %s", __func__, name);
    if (strcmp(name, "AppleLanguagePreferencesChangedNotification") == 0 ||
        strcmp(name, "AFLanguageCodeDidChangeDarwinNotification") == 0 ||
        strcmp(name, "com.apple.coregraphics.GUIConsoleSessionChanged") == 0) {
        // [EligibilityEngine.sharedInstance recomputeAllDomainAnswers];
    }
}

void main_block_invoke_3(xpc_object_t object, dispatch_queue_t queue) {
    xpc_type_t type = xpc_get_type(object);
    if (type != XPC_TYPE_CONNECTION) {
        return;
    }
    xpc_connection_t connection = (xpc_connection_t)object;
    xpc_connection_set_target_queue(connection, queue);
    xpc_connection_set_event_handler(connection, ^(xpc_object_t  _Nonnull object) {
        _connectionHandler(object, connection);
    });
    xpc_connection_resume(connection);
    if ([GlobalConfiguration.sharedInstance isMemoryConstrainedDevice]) {
        if (!source) {
            source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_event_handler(source, ^{
                _tryExitWhenCleanOnWorkloop_block_invoke();
            });
        }
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3e10);
        dispatch_source_set_timer(source, time, DISPATCH_TIME_FOREVER, 1e9);
        dispatch_activate(source);
    }
}

void asyncBlock(dispatch_queue_t queue, dispatch_block_t block) {
    // TODO
    os_transaction_t transaction = os_transaction_create("com.apple.eligibilityd.async-block");
    
    dispatch_async(queue, ^{
        @autoreleasepool {
            block();
        }
    });
}

void _sendInputsNeededNotification(void) {
    // TODO
    uint32_t status = notify_post("com.apple.os-eligibility-domain.input-needed");
    if (status != 0) {
//  os_log_error(eligibility_log(), "%s: Could not send inputs needed notification \"com.apple.os-eligibility-domain.input-needed\""), );
    }
}

void _createDirectoryAtPath(void) {
    // TODO
}

void copy_eligibility_domain_daemon_directory_path(void) {
    char *x;
    int size = asprintf(&x, "%s%s", "/", "/private/var/db/os_eligibility");
    if (size == -1) {
        os_log_error(eligibility_log(), "%s: Failed to construct absolute path for relative path: %s", __FUNCTION__, "/private/var/db/os_eligibility");
    }
    // TODO
}

void _connectionHandler(xpc_object_t object, xpc_connection_t connection) {
    audit_token_t auditToken = {};
    xpc_connection_get_audit_token(connection, &auditToken);
    
    pid_t pid = xpc_connection_get_pid(connection);
    char pathBuffer[8];
    int pathLength = proc_pidpath(pid, pathBuffer, sizeof(pathBuffer));
    NSString *processName = nil;
    if (pathLength >= 1) {
        processName = [NSFileManager.defaultManager stringWithFileSystemRepresentation:pathBuffer length:pathLength].lastPathComponent;
    } else {
        processName = @"(unknown)";
    }
    NSString *process = [NSString stringWithFormat:@"%@(%d)", processName, pid];
    char *description = xpc_copy_description(object);
    os_log(eligibility_log(), "%s: Message from %@: %s", __func__, process, description);
    free(description);
    
    if (xpc_get_type(object) == XPC_TYPE_ERROR) {
        const char *error = xpc_dictionary_get_string(object, XPC_ERROR_KEY_DESCRIPTION);
        os_log_error(eligibility_log(), "%s: Received xpc error: %s", __func__, error);
        return;
    }
    xpc_object_t reply = xpc_dictionary_create_reply(object);
    if (!reply) {
        os_log_error(eligibility_log(), "%s: Failed to construct reply message, canceling connection", __func__);
        xpc_connection_cancel(connection);
        return;
    }
    
    uint64_t messageType = eligibility_xpc_get_message_type(object);
    switch (messageType) {
        case 0:
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
            // TODO
            break;
        default:
            xpc_connection_cancel(connection);
            break;
    }
}

uint64_t eligibility_xpc_get_message_type(xpc_object_t object) {
    xpc_type_t type = xpc_get_type(object);
    if (type != XPC_TYPE_DICTIONARY) {
        os_log_error(eligibility_log(), "%s: xpc message type must be a dictionary", __func__);
        return -1;
    }
    return xpc_dictionary_get_uint64(object, "eligibility_message_type") - 1;
}

bool _checkEntitlement(void) {
    return NO;
}

void _tryExitWhenCleanOnWorkloop_block_invoke(void) {
    intptr_t result = dispatch_source_testcancel(source);
    if (result) {
        return;
    }
    os_log(eligibility_log(), "%s: Running on a memory-constrained device; eager exiting when clean", __func__);
    xpc_transaction_exit_clean();
}
