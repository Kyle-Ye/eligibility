//
//  DeviceLocaleInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "DeviceLocaleInput.h"
#import "EligibilityLog.h"
#import "EligibilityDefine.h"
#import "XPCSPI.h"

@implementation DeviceLocaleInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithDeviceLocale:(nullable xpc_object_t)xpcLocale
                                status:(EligibilityInputStatus)status
                               process:(NSString *)process {
    NSString *deviceLocale;
    if (xpcLocale != nil) {
        xpc_type_t type = xpc_get_type(xpcLocale);
        if (type != XPC_TYPE_STRING) {
            os_log_error(eligibility_log(), "%s: Device locale code input is wrong data type: %s", __func__, xpc_type_get_name(type));
            return nil;
        }
        deviceLocale = (__bridge NSString*)_CFXPCCreateCFObjectFromXPCObject(xpcLocale);
    } else {
        deviceLocale = nil;
    }
    self = [super initWithInputType:EligibilityInputTypeDeviceLocale status:status process:process];
    if (self) {
        self.deviceLocale = deviceLocale;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.deviceLocale forKey:@"deviceLocale"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.deviceLocale = [coder decodeObjectOfClass:NSString.class
                                               forKey:@"deviceLocale"];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    DeviceLocaleInput *copiedInput = [super copyWithZone:zone];
    copiedInput.deviceLocale = [self.deviceLocale copyWithZone:zone];
    return copiedInput;
}

- (NSUInteger)hash {
    return [self.deviceLocale hash] ^ [super hash];
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
        DeviceLocaleInput *otherInput = (DeviceLocaleInput *)other;
        if (!AreObjectsEqual(self.deviceLocale, otherInput.deviceLocale)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "countryCode");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[DeviceLocaleInput deviceLocale:\\\"%@\\\" %@]", self.deviceLocale, [super description]];
}

@end
