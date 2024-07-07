//
//  XPCSPI.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/22.
//

#include <dispatch/dispatch.h>
#include <os/object.h>
#include <xpc/xpc.h>

OS_OBJECT_DECL(os_transaction);

extern os_transaction_t os_transaction_create(const char *description);
extern void xpc_transaction_exit_clean(void);
extern void xpc_connection_get_audit_token(xpc_connection_t, audit_token_t*);
extern xpc_object_t xpc_copy_entitlement_for_token(const char *, audit_token_t *);

extern CFTypeRef _CFXPCCreateCFObjectFromXPCObject(xpc_object_t object);
extern CFTypeRef _CFXPCCreateCFObjectFromXPCMessage(xpc_object_t message);
extern xpc_object_t _CFXPCCreateXPCObjectFromCFObject(CFTypeRef cfObject);
extern xpc_object_t _CFXPCCreateXPCMessageWithCFObject(CFTypeRef cfObject);
