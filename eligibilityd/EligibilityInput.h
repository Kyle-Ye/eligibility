//
//  EligibilityInput.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface EligibilityInput : NSObject<NSSecureCoding, NSCopying>

@property(nonatomic, assign) uint64_t type; // +0x8
@property(nonatomic, assign) uint64_t status; // +0x10
@property(nonatomic, strong) NSDate *setTime; // +0x18
@property(nonatomic, strong) NSString *settingProccessName; // +0x20

- (instancetype)initWithInputType:(int64_t)type status:(int64_t)status process:(NSString *)process;

@end

NS_ASSUME_NONNULL_END
