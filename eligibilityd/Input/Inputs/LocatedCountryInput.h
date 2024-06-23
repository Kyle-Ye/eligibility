//
//  LocatedCountryInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/19.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocatedCountryInput : EligibilityInput

@property(nonatomic, strong) NSSet *countryCodes;

- (instancetype)initWithCountryCodes:(nullable xpc_object_t)countryCodes
                              status:(EligibilityInputStatus)status
                             process:(nullable NSString *)process;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
