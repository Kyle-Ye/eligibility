//
//  main.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "EligibilityXPC.h"
#import "EligibilityUtils.h"

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
