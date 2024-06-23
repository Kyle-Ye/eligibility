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

os_transaction_t os_transaction_create(const char *description);

CFTypeRef _CFXPCCreateCFObjectFromXPCObject(xpc_object_t xpcattrs);
