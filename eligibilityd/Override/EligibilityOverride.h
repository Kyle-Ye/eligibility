//
//  EligibilityOverride.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityAnswerHelper.h"
#import "EligibilityDomainTypeHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityOverride : NSObject<NSSecureCoding, NSCopying>

@property(nonatomic, strong, readonly) NSMutableDictionary *overrideMap;

- (instancetype)init;
- (void)forceDomain:(EligibilityDomainType)domain answer:(EligibilityAnswer)answer context:(nullable NSDictionary *)context;
- (void)resetAnswerForDomain:(EligibilityDomainType)domain;
- (void)resetAllAnswers;
- (NSDictionary *)overrideResultDictionaryForDomain:(EligibilityDomainType)domain;

@end

NS_ASSUME_NONNULL_END
