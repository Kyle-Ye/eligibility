//
//  CountryBillingInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryBillingInput : EligibilityInput

@property(nonatomic, strong) NSString *countryCode;

- (instancetype)initWithBillingCountry:(nullable xpc_object_t)xpcCountry
                              status:(EligibilityInputStatus)status
                             process:(nullable NSString *)process;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
