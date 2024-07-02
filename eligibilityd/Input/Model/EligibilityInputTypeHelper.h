//
//  EligibilityInputTypeHelper.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/17.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityInputType.h"

NS_ASSUME_NONNULL_BEGIN

const char * _Nullable eligibility_input_to_str(EligibilityInputType type);
NSString *eligibility_input_to_NSString(EligibilityInputType type);

NS_ASSUME_NONNULL_END
