//
//  TestDomain.h
//  eligibilityd
//
//  Created by Kyle on 2024/7/1.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityDomain.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestDomain : EligibilityDomain

- (NSString *)expectedCountryCode;

@end

NS_ASSUME_NONNULL_END
