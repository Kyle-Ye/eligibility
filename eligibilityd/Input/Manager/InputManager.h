//
//  InputManager.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputManager : NSObject

@property (nonatomic, strong) NSDictionary *eligibilityInputs;
@property (nonatomic, strong, readonly) NSDictionary *debugDictionary;

+ (instancetype)sharedInstance;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (BOOL)setInput:(EligibilityInput *)input withError:(NSError * _Nullable *)errorPtr;
- (EligibilityInput *)objectForInputValue:(EligibilityInputType)inputType;
@end

NS_ASSUME_NONNULL_END
