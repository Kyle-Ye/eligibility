//
//  eligibility_xpc.h
//  eligibility_xpc
//
//  Created by Kyle on 2024/7/3.
//  Audited for RELEASE_2024_BETA_1
//  Status: WIP

#ifndef eligibility_xpc_h
#define eligibility_xpc_h

#include "EligibilityXPCMessageType.h"
#include <xpc/xpc.h>

EligibilityXPCMessageType eligibility_xpc_get_message_type(xpc_object_t object);
void eligibility_xpc_set_message_type(xpc_object_t message, EligibilityXPCMessageType message_type);
int64_t eligibility_xpc_send_message_with_reply(xpc_object_t message, xpc_object_t* reply_ptr);

#endif /* eligibility_xpc_h */
