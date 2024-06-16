//
//  EligibilityInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityInput : NSObject<NSSecureCoding, NSCopying>

@property(nonatomic, assign) NSUInteger type; // +0x8
@property(nonatomic, assign) NSUInteger status; // +0x10
@property(nonatomic, strong) NSDate *setTime; // +0x18
@property(nonatomic, strong, nullable) NSString *settingProccessName; // +0x20

- (instancetype)initWithInputType:(NSUInteger)type status:(NSUInteger)status process:(NSString * _Nullable)process;

@end

NS_ASSUME_NONNULL_END
