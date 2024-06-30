//
//  EligibilityTimer.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityTimer : NSObject<NSSecureCoding, NSCopying>

+ (BOOL)supportsSecureCoding;
- (instancetype)initWithSeconds:(NSUInteger)seconds;
- (void)setDurationWithSeconds:(NSUInteger)seconds;
- (void)enable;
- (void)resume;
- (void)reset;
- (BOOL)hasExpired;
- (BOOL)isActive;
@end

NS_ASSUME_NONNULL_END
