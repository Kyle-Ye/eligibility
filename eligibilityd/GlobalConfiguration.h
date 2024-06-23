//
//  GlobalConfi.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalConfiguration : NSObject

+(instancetype)sharedInstance;

- (BOOL)isMemoryConstrainedDevice;

@end

NS_ASSUME_NONNULL_END
