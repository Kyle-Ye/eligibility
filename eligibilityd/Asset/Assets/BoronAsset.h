//
//  BoronAsset.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoronAsset : NSObject <NSCopying>

@property(nonatomic, strong) NSSet *countryCodes;
@property(nonatomic, assign) NSUInteger gracePeriodInSeconds;

@end

NS_ASSUME_NONNULL_END
