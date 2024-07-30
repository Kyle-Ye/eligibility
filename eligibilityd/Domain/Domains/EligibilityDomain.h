//
//  EligibilityDomain.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import "EligibilityDomainTypeHelper.h"
#import "EligibilityAnswerHelper.h"
#import "EligibilityAnswerSourceHelper.h"
#import "EligibilityInput.h"
#import "EligibilityInputTypeHelper.h"
#import "EligibilityInputTypes.h"
#import "EligibilityInputStatusHelper.h"

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

@property(nonatomic, assign, readonly) BOOL invertLocatedCountries;
@property(nonatomic, assign, readonly) BOOL invertBillingCountries;
@property(nonatomic, assign, readonly) EligibilityAnswer answer;
@property(nonatomic, strong, readonly, nullable) NSDictionary *context;
@property(nonatomic, assign, readonly) EligibilityInputTypes supportedInputs;
@property(nonatomic, strong, readonly, nullable) NSSet *locatedCountriesOfInterest;
@property(nonatomic, strong, readonly, nullable) NSSet *billingCountriesOfInterest;
@property(nonatomic, strong, readonly, nullable) NSSet *deviceClassesOfInterest;
@property(nonatomic, strong, readonly, nullable) NSSet *deviceLocalesOfInterest;
@property(nonatomic, strong, readonly, nullable) NSSet *deviceRegionCodesOfInterest;
@property(nonatomic, strong, readonly, nullable) NSSet *deviceLanguagesOfInterest;

@property(nonatomic, assign, readonly) EligibilityAnswerSource answerSource;
@property(nonatomic, strong, readonly) NSDictionary * status;
@property(nonatomic, assign, readonly) EligibilityAnswer defaultAnswer;
@property(nonatomic, assign, readonly) EligibilityDomainType domain;
@property(nonatomic, strong, readonly) NSNotificationName domainChangeNotificationName;

- (void)updateParameters;
- (instancetype)init;

- (void)setLocatedCountriesOfInterest:(nullable NSSet *)locatedCountriesOfInterest isInverted:(BOOL)inverted;
- (void)setLocatedCountriesOfInterest:(nullable NSSet *)locatedCountriesOfInterest;
- (void)setLocatedCountriesOfInterest:(nullable NSSet *)locatedCountriesOfInterest withGracePeriod:(NSUInteger)gracePeriod;
- (void)setLocatedCountriesOfInterest:(nullable NSSet *)locatedCountriesOfInterest withGracePeriod:(NSUInteger)gracePeriod isInverted:(BOOL)inverted;
- (void)setBillingCountriesOfInterest:(nullable NSSet *)billingCountriesOfInterest isInverted:(BOOL)inverted;
- (void)setBillingCountriesOfInterest:(nullable NSSet *)billingCountriesOfInterest;
- (void)setDeviceClassesOfInterest:(nullable NSSet *)deviceClassesOfInterest;
- (void)setDeviceLocalesOfInterest:(nullable NSSet *)deviceLocalesOfInterest;
- (void)setLocatedCountryInterest;
- (void)setBillingCountryInterest;
- (void)setChinaCellularInterest;
- (void)setDeviceRegionInterest;
- (void)setDeviceRegionCodesOfInterest:(nullable NSSet *)deviceRegionCodesOfInterest;
- (void)setDeviceLanguageInterest;
- (void)setDeviceLanguagesOfInterest:(nullable NSSet *)deviceLanguagesOfInterest;
- (void)setGenerativeModelSystemVersionInterest;
- (void)setGreymatterQueueInterest;
- (void)setSiriLanguageInterest;
- (void)setExternalBootInterest;
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

- (NSDictionary *)serialize;
- (EligibilityAnswer)computeAnswerFromStatus:(NSDictionary *)status;
- (EligibilityAnswer)computeAnswerFromStatusWithError:(NSError * _Nullable *)errorPtr;
- (void)addContextForKey:(NSString *)key value:(nullable id)value;

@end

NS_ASSUME_NONNULL_END
