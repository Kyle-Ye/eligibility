//
//  DeviceRegionCodeInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "DeviceRegionCodeInput.h"
#import "EligibilityLog.h"

NSString *MGGetStringAnswer(NSString *);

@interface DeviceRegionCodeInput ()

@property(nonatomic, class, readonly) NSString * _mgDeviceRegionCode;

@end

@implementation DeviceRegionCodeInput

+ (NSString *)_mgDeviceRegionCode {
    return MGGetStringAnswer(@"RegionCode");
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init {
    self = [super initWithInputType:6 status:0 process:@"eligibilityd"];
    if (self) {
        self.deviceRegionCode = DeviceRegionCodeInput._mgDeviceRegionCode;
    }
    return self;
}

- (BOOL)isChinaSKU {
    return [[self deviceRegionCode] isEqualTo:@"CH"];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
}
    
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.deviceRegionCode = DeviceRegionCodeInput._mgDeviceRegionCode;
    }
    return self;
}
    
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    DeviceRegionCodeInput *copiedInput = [super copyWithZone:zone];
    copiedInput.deviceRegionCode = [self.deviceRegionCode copyWithZone:zone];
    return copiedInput;
}

- (NSUInteger)hash {
    return [self.deviceRegionCode hash] ^ [super hash];
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
        DeviceRegionCodeInput *otherInput = (DeviceRegionCodeInput *)other;
        if (self.deviceRegionCode != otherInput.deviceRegionCode) {
            os_log_with_type(eligibility_log(), OS_LOG_TYPE_DEFAULT, "%s: Property %s did not match", "-[DeviceRegionCodeInput isEqual:]", "deviceRegionCode");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[DeviceRegionCodeInput deviceRegionCode:\\\"%@\\\" %@]", self.deviceRegionCode, [super description]];
}

@end
