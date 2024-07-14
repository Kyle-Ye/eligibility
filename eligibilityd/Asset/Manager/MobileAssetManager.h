//
//  MobileAssetManager.h
//  eligibilityd
//
//  Created by Kyle on 2024/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobileAssetManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, retain) NSObject<OS_dispatch_queue> *internalQueue;
@property (nonatomic, retain) NSObject<OS_dispatch_queue> *mobileAssetQueue;


- (void)asyncRefetchMobileAsset;
@end

NS_ASSUME_NONNULL_END
