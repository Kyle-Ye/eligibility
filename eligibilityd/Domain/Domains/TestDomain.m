//
//  TestDomain.m
//  eligibilityd
//
//  Created by Kyle on 2024/7/1.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "TestDomain.h"

@interface TestDomain ()
- (void)_internal_doInit;
@end

@implementation TestDomain

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (EligibilityDomainType)domain {
    return EligibilityDomainTypeTest;
}

- (NSNotificationName)domainChangeNotificationName {
    return @"com.apple.os-eligibility-domain.change.test";
}

- (void)_internal_doInit {
    [self updateParameters];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _internal_doInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _internal_doInit];
    }
    return self;
}

- (NSString *)expectedCountryCode {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.apple.eligibilityd"];
    return [defaults stringForKey:@"ExpectedCountryCode"];
}

- (void)updateParameters {
    NSString *countryCode = [self expectedCountryCode];
    if (countryCode) {
        NSSet *countryCodes = [NSSet setWithObject:countryCode];
        [self setLocatedCountriesOfInterest:countryCodes];
        [self setBillingCountriesOfInterest:countryCodes];
    }
}

- (EligibilityAnswer)computeWithError:(NSError * _Nullable *)errorPtr {
    return [self computeAnswerFromStatusWithError:errorPtr];
}

@end
