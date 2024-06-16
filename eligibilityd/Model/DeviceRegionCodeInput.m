//
//  DeviceRegionCodeInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import "DeviceRegionCodeInput.h"

NSString *MGGetStringAnswer(NSString *);

@implementation DeviceRegionCodeInput

+ (NSString *)_mgDeviceRegionCode {
    return MGGetStringAnswer(@"RegionCode");
}

+ (BOOL)supportsSecureCoding { return YES; }

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.deviceRegionCode = @"";
    }
    return self;
}

- (BOOL)isChinaSKU {
    return [[self deviceRegionCode] isEqualTo:@"CH"];
}


@end

//; @class DeviceRegionCodeInput : EligibilityInput<NSSecureCoding, NSCopying> {
//                            ;     @property deviceRegionCode
//                            ;     @property isChinaSKU
//                            ;     ivar _deviceRegionCode
//                            ;     +_mgDeviceRegionCode
//                            ;     +supportsSecureCoding
//                            ;     -init
//                            ;     -isChinaSKU
//                            ;     -encodeWithCoder:
//                            ;     -initWithCoder:
//                            ;     -copyWithZone:
//                            ;     -hash
//                            ;     -isEqual:
//                            ;     -description
//                            ;     -.cxx_destruct
//                            ; }
