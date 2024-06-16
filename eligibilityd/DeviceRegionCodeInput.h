//
//  DeviceRegionCodeInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceRegionCodeInput : EligibilityInput<NSSecureCoding, NSCopying>
+(NSString *) _mgDeviceRegionCode;
@property(nonatomic, strong) NSString *deviceRegionCode;
@property(nonatomic, assign, readonly) BOOL isChinaSKU;

@end

NS_ASSUME_NONNULL_END
