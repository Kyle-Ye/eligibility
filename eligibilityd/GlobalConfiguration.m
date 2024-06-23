//
//  GlobalConfiguration.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//  WIP

#import "GlobalConfiguration.h"

@implementation GlobalConfiguration

+ (instancetype)sharedInstance {
    return [[GlobalConfiguration alloc] init];
}

- (BOOL)isMemoryConstrainedDevice {
    return NO;
}

- (BOOL)testMode {
    return NO;
}

- (BOOL)setTestMode:(BOOL)testMode withError:(NSError * _Nullable *)error {
    return NO;
}

@end
