//
//  SiriLanguageInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface SiriLanguageInput : EligibilityInput

@property(nonatomic, strong, readonly) NSString *language;

@end

NS_ASSUME_NONNULL_END
