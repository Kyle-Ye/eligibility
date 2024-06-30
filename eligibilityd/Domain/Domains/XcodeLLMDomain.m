//
//  XcodeLLMDomain.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "XcodeLLMDomain.h"

@interface XcodeLLMDomain ()
- (void)_internal_doInit;
@end

@implementation XcodeLLMDomain

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (EligibilityDomainType)domain {
    return EligibilityDomainTypeXcodeLLM;
}

- (NSNotificationName)domainChangeNotificationName {
    return @"com.apple.os-eligibility-domain.change.xcode-llm";
}

- (void)_internal_doInit {
    [self setDeviceRegionInterest];    
    [self setDeviceClassesOfInterest:[NSSet setWithObject:@"Mac"]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _internal_doInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _internal_doInit];
    }
    return self;
}

- (void)updateParameters {
    return;
}

- (EligibilityInputStatus)computeInputStatusForDeviceRegionCodesInput:(DeviceRegionCodeInput *)input {
    return input.isChinaSKU ? EligibilityInputStatusNotEligible : EligibilityInputStatusEligible;
}

@end
