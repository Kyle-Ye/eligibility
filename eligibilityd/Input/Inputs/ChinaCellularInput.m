//
//  ChinaCellularInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "ChinaCellularInput.h"
#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "MobileGestalt.h"

@interface ChinaCellularInput ()

@property(nonatomic, class, assign, readonly) BOOL _isGreenTeaDeviceCapable;

@end

@implementation ChinaCellularInput

+ (BOOL)_isGreenTeaDeviceCapable {
    return MGGetBoolAnswer((__bridge CFStringRef)@"green-tea");
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init {
    self = [super initWithInputType:EligibilityInputTypeChinaCellular status:EligibilityInputStatusNone process:@"eligibilityd"];
    if (self) {
        self.chinaCellularDevice = ChinaCellularInput._isGreenTeaDeviceCapable;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
}
    
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithInputType:EligibilityInputTypeChinaCellular status:EligibilityInputStatusNone process:@"eligibilityd"];
    if (self) {
        self.chinaCellularDevice = ChinaCellularInput._isGreenTeaDeviceCapable;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    ChinaCellularInput *copiedInput = [super copyWithZone:zone];
    copiedInput.chinaCellularDevice = self.chinaCellularDevice;
    return copiedInput;
}

- (NSUInteger)hash {
    return self.chinaCellularDevice ^ [super hash];
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
        ChinaCellularInput *otherInput = (ChinaCellularInput *)other;
        if (self.chinaCellularDevice != otherInput.chinaCellularDevice) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "chinaCellularDevice");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[ChinaCellularInput chinaCellularDevice:%@ %@]", self.chinaCellularDevice ? @"Y" : @"N", [super description]];
}

@end
