//
//  DeviceLanguageInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_1_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceLanguageInput : EligibilityInput

@property(nonatomic, strong, readonly) NSArray *deviceLanguages;

/// A BCP 47 language identifier, such as en-US.
@property(nonatomic, strong, readonly) NSString *primaryLanguage;

@end

NS_ASSUME_NONNULL_END
