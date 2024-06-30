//
//  DeviceClassInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import "DeviceClassInput.h"
#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "MobileGestalt.h"

@interface DeviceClassInput ()

@property(nonatomic, class, readonly) NSString * _mgDeviceClass;

@end

@implementation DeviceClassInput

+ (NSString *)_mgDeviceClass {
    return (__bridge NSString *)MGGetStringAnswer((__bridge CFStringRef)@"DeviceClass");
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init {
    self = [super initWithInputType:EligibilityInputTypeDeviceClass status:EligibilityInputStatusNone process:@"eligibilityd"];
    if (self) {
        self.deviceClass = DeviceClassInput._mgDeviceClass;
    }
    return self;
}

- (BOOL)isiPad {
    return [self.deviceClass isEqualToString:@"iPad"];
}

- (BOOL)isiPhone {
    return [self.deviceClass isEqualToString:@"iPhone"];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
}
    
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithInputType:EligibilityInputTypeDeviceClass status:EligibilityInputStatusNone process:@"eligibilityd"];
    if (self) {
        self.deviceClass = DeviceClassInput._mgDeviceClass;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    DeviceClassInput *copiedInput = [super copyWithZone:zone];
    copiedInput.deviceClass = [self.deviceClass copyWithZone:zone];
    return copiedInput;
}

- (NSUInteger)hash {
    return [self.deviceClass hash] ^ [super hash];
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
        DeviceClassInput *otherInput = (DeviceClassInput *)other;
        if (!AreObjectsEqual(self.deviceClass, otherInput.deviceClass)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "deviceClass");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[DeviceClassInput deviceClass:\\\"%@\\\" %@]", self.deviceClass, [super description]];
}

@end
