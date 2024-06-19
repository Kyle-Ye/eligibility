//
//  DeviceRegionCodeInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceRegionCodeInput : EligibilityInput

@property(nonatomic, strong) NSString *deviceRegionCode;
@property(nonatomic, assign, readonly) BOOL isChinaSKU;

@end

NS_ASSUME_NONNULL_END
