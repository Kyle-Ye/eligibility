//
//  DeviceClassInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceClassInput : EligibilityInput

@property(nonatomic, strong) NSString *deviceClass;

@property(nonatomic, assign, readonly) BOOL isiPad;
@property(nonatomic, assign, readonly) BOOL isiPhone;

@end

NS_ASSUME_NONNULL_END
