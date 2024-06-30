//
//  GreymatterQueueInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "GreymatterQueueInput.h"
#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "XPCSPI.h"

@implementation GreymatterQueueInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initOnQueue:(xpc_object_t)xpcQueue
                     status:(EligibilityInputStatus)status
                    process:(NSString *)process {
    BOOL onGreymatterQueue;
    if (xpcQueue != nil) {
        xpc_type_t type = xpc_get_type(xpcQueue);
        if (type != XPC_TYPE_BOOL) {
            os_log_error(eligibility_log(), "%s: Greymatter Queue state input is wrong data type: %s", __func__, xpc_type_get_name(type));
            return nil;
        }
        onGreymatterQueue = xpc_bool_get_value(xpcQueue);
    } else {
        onGreymatterQueue = NO;
    }
    self = [super initWithInputType:EligibilityInputTypeGreyMatterOnQueue status:status process:process];
    if (self) {
        self.onGreymatterQueue = onGreymatterQueue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeBool:self.onGreymatterQueue forKey:@"onGreymatterQueue"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.onGreymatterQueue = [coder decodeBoolForKey:@"onGreymatterQueue"];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    GreymatterQueueInput *copiedInput = [super copyWithZone:zone];
    copiedInput.onGreymatterQueue = self.onGreymatterQueue;
    return copiedInput;
}

- (NSUInteger)hash {
    return self.onGreymatterQueue ^ [super hash];
}

- (BOOL)isEqual:(id)other {
    if (![super isEqual:other]) {
        return NO;
    } else if (other == self) {
        return YES;
    } else {
        if (![other isKindOfClass:self.class]) {
            return NO;
        }
        GreymatterQueueInput *otherInput = (GreymatterQueueInput *)other;
        if (self.onGreymatterQueue != otherInput.onGreymatterQueue) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "countryCode");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[GreymatterQueueInput onQueue: %@ %@]", self.onGreymatterQueue ? @"Y" : @"N", [super description]];
}

@end
