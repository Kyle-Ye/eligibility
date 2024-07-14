//
//  MobileAssetManager.m
//  eligibilityd
//
//  Created by Kyle on 2024/7/14.
//

#import "MobileAssetManager.h"
#import "EligibilityUtils.h"

@implementation MobileAssetManager

+ (instancetype)sharedInstance {
    static MobileAssetManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (void)asyncRefetchMobileAsset {
    asyncBlock(self.mobileAssetQueue, ^{
        // TODO
    });
}

@end
