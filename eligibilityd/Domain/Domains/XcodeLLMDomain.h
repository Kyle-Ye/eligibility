//
//  XcodeLLMDomain.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityDomain.h"
#import "DeviceRegionCodeInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface XcodeLLMDomain : EligibilityDomain

+ (BOOL)supportsSecureCoding;
- (EligibilityDomainType)domain;
- (NSNotificationName)domainChangeNotificationName;
- (instancetype)init;
- (instancetype)initWithCoder:(NSCoder *)coder;
- (void)updateParameters;
- (EligibilityInputStatus)computeInputStatusForDeviceRegionCodesInput:(DeviceRegionCodeInput *)input;

@end

NS_ASSUME_NONNULL_END
