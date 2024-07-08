//
//  eligibility_xpc.h
//  system_eligibility
//
//  Created by Kyle on 2024/7/3.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef eligibility_xpc_h
#define eligibility_xpc_h

#include "EligibilityXPCMessageType.h"
#include <xpc/xpc.h>

EligibilityXPCMessageType eligibility_xpc_get_message_type(xpc_object_t message);
void eligibility_xpc_set_message_type(EligibilityXPCMessageType message_type, xpc_object_t message);
int eligibility_xpc_send_message_with_reply(xpc_object_t message, xpc_object_t* reply_ptr);

#endif /* eligibility_xpc_h */
