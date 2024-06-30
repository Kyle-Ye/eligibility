//
//  GreymatterQueueInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface GreymatterQueueInput : EligibilityInput

@property(nonatomic, assign) BOOL onGreymatterQueue;

- (instancetype)initOnQueue:(nullable xpc_object_t)xpcQueue
                     status:(EligibilityInputStatus)status
                    process:(nullable NSString *)process;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
