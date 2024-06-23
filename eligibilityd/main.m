//
//  main.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/objc.h>
#include <notify.h>

#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "XPCSPI.h"
#import "GlobalConfiguration.h"

void main_block_invoke_1(void);
void main_block_invoke_2(xpc_object_t object);
void main_block_invoke_3(xpc_object_t object, dispatch_queue_t queue);
void _connectionHandler(xpc_object_t object);
void _tryExitWhenCleanOnWorkloop_block_invoke();

void asyncBlock(dispatch_queue_t queue, dispatch_block_t block);
void _sendInputsNeededNotification(void);
void _createDirectoryAtPath(void);
void copy_eligibility_domain_daemon_directory_path(void);

int main(int argc, const char * argv[]) {
    os_log_info(eligibility_log(), "%s: eligibilityd (%s) built at %s %s started", __func__, VERSION, __DATE__, __TIME__);
    dispatch_workloop_t xpcWorkloop = dispatch_workloop_create("com.apple.eligibility.xpc_workloop");
    dispatch_queue_attr_t xpcHandlerAttr = dispatch_queue_attr_make_with_autorelease_frequency(nil, DISPATCH_AUTORELEASE_FREQUENCY_WORK_ITEM);
    dispatch_queue_t xpcHandlerQueue = dispatch_queue_create_with_target("com.apple.eligibility.xpc_handler", xpcHandlerAttr, xpcWorkloop);
    asyncBlock(xpcHandlerQueue, ^{
        main_block_invoke_1();
    });
    dispatch_queue_attr_t notificationAttr = dispatch_queue_attr_make_with_autorelease_frequency(nil, DISPATCH_AUTORELEASE_FREQUENCY_WORK_ITEM);
    dispatch_queue_t notificationQueue = dispatch_queue_create("com.apple.eligibility.notifications", notificationAttr);
    xpc_set_event_stream_handler("com.apple.notifyd.matching", notificationQueue, ^(xpc_object_t object) {
        main_block_invoke_2(object);
    });
    xpc_connection_t connection = xpc_connection_create_mach_service("com.apple.eligibilityd", xpcHandlerQueue, XPC_CONNECTION_MACH_SERVICE_LISTENER);
    if (!connection) {
        os_log_error(eligibility_log(), "%s: Unable to start xpc service %s", __func__, "com.apple.eligibilityd");
        exit(1);
    }
    xpc_connection_set_event_handler(connection, ^(xpc_object_t  _Nonnull object) {
        main_block_invoke_3(object, xpcWorkloop);
    });
    xpc_connection_activate(connection);
    dispatch_main();
    return 0;
}


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
        // TODO: pass connection into it
        _connectionHandler(object);
    });
    xpc_connection_resume(connection);
    if ([GlobalConfiguration.sharedInstance isMemoryConstrainedDevice]) {
        static dispatch_source_t source;
        if (!source) {
            source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_event_handler(source, ^{
                // TODO
                _tryExitWhenCleanOnWorkloop_block_invoke();
            });
        }
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3e10);
        dispatch_source_set_timer(source, time, DISPATCH_TIME_FOREVER, 1e9);
        dispatch_activate(source);
    }
}

void _connectionHandler(xpc_object_t object) {
    // TODO
}

void _tryExitWhenCleanOnWorkloop_block_invoke() {
    // TODO
}

// TODO
void asyncBlock(dispatch_queue_t queue, dispatch_block_t block) {
    os_transaction_t transaction = os_transaction_create("com.apple.eligibilityd.async-block");
    
    dispatch_async(queue, ^{
        @autoreleasepool {
            block();
        }
    });
}

// TODO
void _sendInputsNeededNotification(void) {
    uint32_t status = notify_post("com.apple.os-eligibility-domain.input-needed");
    if (status != 0) {
//  os_log_error(eligibility_log(), "%s: Could not send inputs needed notification \"com.apple.os-eligibility-domain.input-needed\""), );
    }
}

// TODO
void _createDirectoryAtPath(void) {
    
}

void copy_eligibility_domain_daemon_directory_path(void) {
    char *x;
    int size = asprintf(&x, "%s%s", "/", "/private/var/db/os_eligibility");
    if (size == -1) {
        os_log_error(eligibility_log(), "%s: Failed to construct absolute path for relative path: %s", __FUNCTION__, "/private/var/db/os_eligibility");
    }
    // TODO
}
