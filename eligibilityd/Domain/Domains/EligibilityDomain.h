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
#import "EligibilityInput.h"
#import "EligibilityInputType.h"
#import "EligibilityInputTypes.h"
#import "EligibilityInputStatus.h"

#import "LocatedCountryInput.h"
#import "CountryBillingInput.h"
#import "DeviceClassInput.h"
#import "DeviceLocaleInput.h"
#import "ChinaCellularInput.h"
#import "DeviceRegionCodeInput.h"
#import "DeviceLanguageInput.h"
#import "GenerativeModelSystemInput.h"
#import "GreymatterQueueInput.h"
#import "SiriLanguageInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityDomain : NSObject<NSSecureCoding, NSCopying>

+ (BOOL)supportsSecureCoding;

@property(nonatomic, assign) BOOL invertLocatedCountries;
@property(nonatomic, assign) BOOL invertBillingCountries;
@property(nonatomic, assign) EligibilityAnswer answer;
@property(nonatomic, strong) NSDictionary *context;
@property(nonatomic, assign) EligibilityInputTypes supportedInputs;
@property(nonatomic, strong) NSSet *locatedCountriesOfInterest;
@property(nonatomic, strong) NSSet *billingCountriesOfInterest;
@property(nonatomic, strong) NSSet *deviceClassesOfInterest;
@property(nonatomic, strong) NSSet *deviceLocalesOfInterest;
@property(nonatomic, strong) NSSet *deviceRegionCodesOfInterest;
@property(nonatomic, strong) NSSet *deviceLanguagesOfInterest;

@property(nonatomic, assign, readonly) EligibilityAnswerSource answerSource;
@property(nonatomic, strong, readonly) NSDictionary * status;
@property(nonatomic, assign, readonly) EligibilityAnswer defaultAnswer;
@property(nonatomic, assign, readonly) EligibilityDomainType domain;
@property(nonatomic, strong, readonly) NSNotificationName domainChangeNotificationName;

- (void)updateParameters;
- (instancetype)init;

- (void)setLocatedCountriesOfInterest:(NSSet *)locatedCountriesOfInterest isInverted:(BOOL)inverted;
- (void)setLocatedCountriesOfInterest:(NSSet *)locatedCountriesOfInterest;
- (void)setLocatedCountriesOfInterest:(NSSet *)locatedCountriesOfInterest withGracePeriod:(NSUInteger)gracePeriod;

- (void)setBillingCountriesOfInterest:(NSSet *)billingCountriesOfInterest isInverted:(BOOL)inverted;
- (void)setBillingCountriesOfInterest:(NSSet *)billingCountriesOfInterest;

- (void)resetInputsOfInterest;

- (EligibilityAnswer)computeWithError:(NSError * _Nullable *)errorPtr;
- (EligibilityInputStatus)computeInputStatusForInput:(EligibilityInput *)input;
- (BOOL)isInterestedInInput:(EligibilityInputType)inputType;
- (BOOL)hasActiveGracePeriod;

- (EligibilityInputStatus)computeInputStatusForLocatedCountryInput:(LocatedCountryInput *)input;
- (EligibilityInputStatus)computeInputStatusForBillingCountryInput:(CountryBillingInput *)input;
- (EligibilityInputStatus)computeInputStatusForDeviceClassInput:(DeviceClassInput *)input;
- (EligibilityInputStatus)computeInputStatusForDeviceLocaleInput:(DeviceLocaleInput *)input;
- (EligibilityInputStatus)computeInputStatusForChinaCellularInput:(ChinaCellularInput *)input;
- (EligibilityInputStatus)computeInputStatusForDeviceRegionCodesInput:(DeviceRegionCodeInput *)input;
- (EligibilityInputStatus)computeInputStatusForDeviceLanguageInput:(DeviceLanguageInput *)input;
- (EligibilityInputStatus)computeInputStatusForGenerativeModelSystemInput:(GenerativeModelSystemInput *)input;
- (EligibilityInputStatus)computeInputStatusForGreymatterQueueInput:(GreymatterQueueInput *)input;
- (EligibilityInputStatus)computeInputStatusForSiriLanguageInput:(SiriLanguageInput *)input;

- (void)serialize;
- (EligibilityAnswer)computeAnswerFromStatus:(NSDictionary *)status;
- (EligibilityAnswer)computeAnswerFromStatusWithError:(NSError * _Nullable *)errorPtr;
- (void)addContextForKey:(NSString *)key value:(id)value;

@end

NS_ASSUME_NONNULL_END
