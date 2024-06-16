//
//  BoronAsset.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoronAsset : NSObject <NSCopying>
@property(nonatomic, strong) NSSet *countryCodes; // +0x8
@property(nonatomic, assign) NSUInteger gracePeriodInSeconds; // +0x10
@end

NS_ASSUME_NONNULL_END
