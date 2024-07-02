//
//  EligibilityInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInputTypeHelper.h"
#import "EligibilityInputStatusHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityInput : NSObject<NSSecureCoding, NSCopying>

@property(nonatomic, assign) EligibilityInputType type;
@property(nonatomic, assign) EligibilityInputStatus status;
@property(nonatomic, strong) NSDate *setTime;
@property(nonatomic, strong, nullable) NSString *settingProccessName;

- (instancetype)initWithInputType:(EligibilityInputType)type status:(EligibilityInputStatus)status process:(NSString * _Nullable)process;

@end

NS_ASSUME_NONNULL_END
