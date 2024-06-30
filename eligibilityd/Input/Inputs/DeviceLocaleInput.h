//
//  DeviceLocaleInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceLocaleInput : EligibilityInput

@property(nonatomic, strong) NSString *deviceLocale;

- (instancetype)initWithDeviceLocale:(nullable xpc_object_t)xpcLocale
                              status:(EligibilityInputStatus)status
                             process:(nullable NSString *)process;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
