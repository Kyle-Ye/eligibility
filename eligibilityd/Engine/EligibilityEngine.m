//
//  EligibilityEngine.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import "EligibilityEngine.h"

@implementation EligibilityEngine

+ (instancetype)sharedInstance {
    static EligibilityEngine *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self class] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // TODO
    }
    return self;
}

@end
