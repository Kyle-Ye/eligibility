//
//  EligibilityInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityInput : NSObject<NSSecureCoding, NSCopying>

@property(nonatomic, assign) NSUInteger type;
@property(nonatomic, assign) NSUInteger status;
@property(nonatomic, strong) NSDate *setTime;
@property(nonatomic, strong, nullable) NSString *settingProccessName;

- (instancetype)initWithInputType:(NSUInteger)type status:(NSUInteger)status process:(NSString * _Nullable)process;

@end

NS_ASSUME_NONNULL_END
