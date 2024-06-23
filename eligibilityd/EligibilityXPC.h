//
//  EligibilityXPC.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <xpc/xpc.h>

NS_ASSUME_NONNULL_BEGIN

void main_block_invoke_1(void);
void main_block_invoke_2(xpc_object_t object);
void main_block_invoke_3(xpc_object_t object, dispatch_queue_t queue);

NS_ASSUME_NONNULL_END
