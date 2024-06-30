//
//  EligibilityOverrideData.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityAnswer.h"

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityOverrideData : NSObject<NSSecureCoding, NSCopying>

@property(nonatomic, assign, readonly) EligibilityAnswer answer;
@property(nonatomic, strong, readonly, nullable) NSDictionary *context;

- (instancetype)initWithAnswer:(EligibilityAnswer)answer context:(nullable NSDictionary *)context;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
