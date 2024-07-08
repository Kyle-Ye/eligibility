//
//  eligibility_xpc.c
//  system_eligibility
//
//  Created by Kyle on 2024/7/3.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#include "eligibility_xpc.h"
#include "eligibility_log_handle.h"

EligibilityXPCMessageType eligibility_xpc_get_message_type(xpc_object_t message) {
    xpc_type_t type = xpc_get_type(message);
    if (type != XPC_TYPE_DICTIONARY) {
        os_log_error(eligibility_log_handle(), "%s: xpc message type must be a dictionary", __func__);
        return EligibilityXPCMessageTypeInvalid;
    }
    return xpc_dictionary_get_uint64(message, "eligibility_message_type");
}

void eligibility_xpc_set_message_type(EligibilityXPCMessageType message_type, xpc_object_t message) {
    xpc_type_t type = xpc_get_type(message);
    if (type != XPC_TYPE_DICTIONARY) {
        os_log_error(eligibility_log_handle(), "%s: xpc message type must be a dictionary", __func__);
        return;
    }
    xpc_dictionary_set_uint64(message, "eligibility_message_type", message_type);
}

int eligibility_xpc_send_message_with_reply(xpc_object_t message, xpc_object_t* reply_ptr) {
    xpc_connection_t connection = xpc_connection_create_mach_service("com.apple.eligibilityd", NULL, 0);
    xpc_connection_set_event_handler(connection, ^(xpc_object_t  _Nonnull object) {
    });
    xpc_connection_activate(connection);
    xpc_object_t reply = xpc_connection_send_message_with_reply_sync(connection, message);
    xpc_type_t reply_type = xpc_get_type(reply);
    
    int error_num;
    if (reply_type != NULL && reply_type != XPC_TYPE_ERROR) {
        if (reply_type == XPC_TYPE_DICTIONARY) {
            error_num = (int)xpc_dictionary_get_int64(reply, "errorNum");
        } else {
            error_num = -1;
        }
    } else {
        const char *description = xpc_dictionary_get_string(reply, XPC_ERROR_KEY_DESCRIPTION);
        if (description == NULL) {
            description = "unknown error";
        }
        EligibilityXPCMessageType message_type = eligibility_xpc_get_message_type(message);
        os_log_error(eligibility_log_handle(), "%s: Error returned trying to send xpc message %llu: %s", __func__, message_type, description);
        error_num = ECONNRESET;
    }
    if (reply) {
        if (reply_ptr == NULL || error_num != 0) {
            xpc_release(reply);
        } else {
            *reply_ptr = reply;
        }
    }
    return error_num;
}
