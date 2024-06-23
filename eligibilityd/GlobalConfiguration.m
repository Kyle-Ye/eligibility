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

@end
