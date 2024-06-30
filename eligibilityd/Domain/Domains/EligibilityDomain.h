//
//  EligibilityDomain.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import <Foundation/Foundation.h>
#import "EligibilityDomainType.h"
#import "EligibilityAnswer.h"
#import "EligibilityAnswerSource.h"
#import "EligibilityInputType.h"
#import "EligibilityInputStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityDomain : NSObject<NSSecureCoding, NSCopying>

+ (BOOL)supportsSecureCoding;

- (instancetype)init;
- (instancetype)initWithCoder:(NSCoder *)coder;

@property(nonatomic, assign) BOOL invertLocatedCountries;
@property(nonatomic, assign) BOOL invertBillingCountries;

@property(nonatomic, assign) EligibilityAnswer answer;
@property(nonatomic, assign, readonly) EligibilityAnswer defaultAnswer;
@property(nonatomic, assign, readonly) EligibilityAnswerSource answerSource;
@property(nonatomic, strong, readonly) NSDictionary * status;

@property(nonatomic, strong) NSString *context;
@property(nonatomic, assign) EligibilityInputType supportedInputs;

@property(nonatomic, strong) NSString *locatedCountriesOfInterest;
@property(nonatomic, strong) NSString *billingCountriesOfInterest;
@property(nonatomic, strong) NSString *deviceClassesOfInterest;
@property(nonatomic, strong) NSString *deviceLocalesOfInterest;
@property(nonatomic, strong) NSString *deviceRegionCodesOfInterest;
@property(nonatomic, strong) NSString *deviceLanguagesOfInterest;
@property(nonatomic, strong) NSString *locatedCountryTimer;

@property(nonatomic, assign, readonly) EligibilityDomainType domain;
@property(nonatomic, strong, readonly) NSNotificationName domainChangeNotificationName;
- (void)updateParameters;

- (BOOL)isInterestedInInput:(EligibilityInputType)inputType;
- (void)resetInputsOfInterest;

@end

NS_ASSUME_NONNULL_END
