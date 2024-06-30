//
//  EligibilityDomain.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityDomain.h"
#import "os_private.h"
#import "InputManager.h"
#import "EligibilityLog.h"
#import "EligibilityTimer.h"
#import "EligibilityBase.h"

@interface EligibilityDomain ()

@property(nonatomic, assign) BOOL invertLocatedCountries;
@property(nonatomic, assign) BOOL invertBillingCountries;
@property(nonatomic, assign) EligibilityAnswer answer;
@property(nonatomic, strong, nullable) NSDictionary *context;
@property(nonatomic, assign) EligibilityInputTypes supportedInputs;
@property(nonatomic, strong, nullable) NSSet *locatedCountriesOfInterest;
@property(nonatomic, strong, nullable) NSSet *billingCountriesOfInterest;
@property(nonatomic, strong, nullable) NSSet *deviceClassesOfInterest;
@property(nonatomic, strong, nullable) NSSet *deviceLocalesOfInterest;
@property(nonatomic, strong, nullable) NSSet *deviceRegionCodesOfInterest;
@property(nonatomic, strong, nullable) NSSet *deviceLanguagesOfInterest;
@property(nonatomic, strong, nullable) EligibilityTimer *locatedCountryTimer;

- (EligibilityInputStatus)_computeInputStatusForSet:(NSSet *)set withObject:(id)object isInverted:(BOOL)inverted;
- (NSString *)_supportedInputsString;
- (NSString *)_interestedDataString;

@end

@implementation EligibilityDomain

+(BOOL)supportsSecureCoding {
    return YES;
}

- (EligibilityDomainType)domain {
    os_crash("This property must be overridden");
}

- (NSNotificationName)domainChangeNotificationName {
    os_crash("This property must be overridden");
}

- (void)updateParameters {
    os_crash("This method must be overridden");
}

- (EligibilityAnswer)defaultAnswer {
    return EligibilityAnswerNotEligible;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _answer = EligibilityAnswerInvalid;
        _context = nil;
        _supportedInputs = EligibilityInputTypesInvalid;
    }
    return self;
}

- (void)setLocatedCountriesOfInterest:(nullable NSSet *)locatedCountriesOfInterest isInverted:(BOOL)inverted {
    if (locatedCountriesOfInterest) {
        self.supportedInputs |= EligibilityInputTypesCountryLocation;
    } else {
        self.supportedInputs &= ~EligibilityInputTypesCountryLocation;
    }
    _locatedCountriesOfInterest = locatedCountriesOfInterest;
    _invertLocatedCountries = inverted;
}

- (void)setLocatedCountriesOfInterest:(nullable NSSet *)locatedCountriesOfInterest {
    [self setLocatedCountriesOfInterest:locatedCountriesOfInterest isInverted:NO];
}

- (void)setLocatedCountriesOfInterest:(nullable NSSet *)locatedCountriesOfInterest withGracePeriod:(NSUInteger)gracePeriod {
    [self setLocatedCountriesOfInterest:locatedCountriesOfInterest];
    EligibilityTimer *timer = self.locatedCountryTimer;
    if (timer) {
        [timer setDurationWithSeconds:gracePeriod];
    } else {
        timer = [[EligibilityTimer alloc] initWithSeconds:gracePeriod];
    }
    self.locatedCountryTimer = timer;
}

- (void)setBillingCountriesOfInterest:(nullable NSSet *)billingCountriesOfInterest isInverted:(BOOL)inverted {
    if (billingCountriesOfInterest) {
        self.supportedInputs |= EligibilityInputTypesCountryBilling;
    } else {
        self.supportedInputs &= ~EligibilityInputTypesCountryBilling;
    }
    _billingCountriesOfInterest = billingCountriesOfInterest;
    _invertBillingCountries = inverted;
}

- (void)setBillingCountriesOfInterest:(nullable NSSet *)billingCountriesOfInterest {
    [self setBillingCountriesOfInterest:billingCountriesOfInterest isInverted:NO];
}

- (void)setDeviceClassesOfInterest:(nullable NSSet *)deviceClassesOfInterest {
    if (deviceClassesOfInterest) {
        self.supportedInputs |= EligibilityInputTypesDeviceClass;
    } else {
        self.supportedInputs &= ~EligibilityInputTypesDeviceClass;
    }
    _deviceClassesOfInterest = deviceClassesOfInterest;
}

- (void)setDeviceLocalesOfInterest:(nullable NSSet *)deviceLocalesOfInterest {
    if (deviceLocalesOfInterest) {
        self.supportedInputs |= EligibilityInputTypesDeviceLocale;
    } else {
        self.supportedInputs &= ~EligibilityInputTypesDeviceLocale;
    }
    _deviceLocalesOfInterest = deviceLocalesOfInterest;
}

- (void)setLocatedCountryInterest {
    self.supportedInputs |= EligibilityInputTypesCountryLocation;
}

- (void)setBillingCountryInterest {
    self.supportedInputs |= EligibilityInputTypesCountryBilling;
}

- (void)setChinaCellularInterest {
    self.supportedInputs |= EligibilityInputTypesChinaCellular;
}

- (void)setDeviceRegionInterest {
    self.supportedInputs |= EligibilityInputTypesDeviceRegionCode;
}

- (void)setDeviceRegionCodesOfInterest:(nullable NSSet *)deviceRegionCodesOfInterest {
    if (deviceRegionCodesOfInterest) {
        self.supportedInputs |= EligibilityInputTypesDeviceRegionCode;
    } else {
        self.supportedInputs &= ~EligibilityInputTypesDeviceRegionCode;
    }
    _deviceRegionCodesOfInterest = deviceRegionCodesOfInterest;
}

- (void)setDeviceLanguageInterest {
    self.supportedInputs |= EligibilityInputTypesDeviceLanguage;
}

- (void)setDeviceLanguagesOfInterest:(nullable NSSet *)deviceLanguagesOfInterest {
    if (deviceLanguagesOfInterest) {
        self.supportedInputs |= EligibilityInputTypesDeviceLanguage;
    } else {
        self.supportedInputs &= ~EligibilityInputTypesDeviceLanguage;
    }
    _deviceLanguagesOfInterest = deviceLanguagesOfInterest;
}

- (void)setGenerativeModelSystemVersionInterest {
    self.supportedInputs |= EligibilityInputTypesGenerativeModelSystem;
}

- (void)setGreymatterQueueInterest {
    self.supportedInputs |= EligibilityInputTypesGreyMatterOnQueue;
}

- (void)setSiriLanguageInterest {
    self.supportedInputs |= EligibilityInputTypesSiriLanguage;
}

- (void)resetInputsOfInterest {
    self.locatedCountriesOfInterest = nil; // FIXME: TO BE AUDITED
    self.locatedCountriesOfInterest = nil;
    self.deviceClassesOfInterest = nil;
    self.billingCountriesOfInterest = nil;
    self.deviceLocalesOfInterest = nil;
    self.deviceRegionCodesOfInterest = nil;
    self.deviceLanguagesOfInterest = nil;
}

- (EligibilityAnswerSource)answerSource {
    return EligibilityAnswerSourceComputed;
}

- (NSDictionary *)status {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    InputManager *manager = InputManager.sharedInstance;
    EligibilityInputType inputType = EligibilityInputTypeCountryLocation;
    do {
        if (![self isInterestedInInput:inputType]) {
            inputType += 1;
            continue;
        }
        EligibilityInput *input = [manager objectForInputValue:inputType];
        EligibilityInputStatus status;
        if (input) {
            if (input.status == EligibilityInputStatusNone) {
                status = [self computeInputStatusForInput:input];
            } else {
                status = input.status;
            }
        } else {
            status = EligibilityInputStatusNotSet;
        }
        NSNumber *statusNumber = [NSNumber numberWithUnsignedLongLong:status];
        NSString *typeString = eligibility_input_to_NSString(inputType);
        dict[typeString] = statusNumber;
        inputType += 1;
    } while (inputType <= EligibilityInputTypeCount);
    return dict.copy;
}

- (EligibilityAnswer)computeWithError:(NSError * _Nullable *)errorPtr {
    return [self computeAnswerFromStatusWithError:errorPtr];
}

- (EligibilityInputStatus)computeInputStatusForInput:(EligibilityInput *)input {
    EligibilityInputType inputType = input.type;
    if (![self isInterestedInInput:inputType]) {
        return EligibilityInputStatusNone;
    }
    switch (inputType) {
        case EligibilityInputTypeCountryLocation:
            return [self computeInputStatusForLocatedCountryInput:(LocatedCountryInput *)input];
        case EligibilityInputTypeCountryBilling:
            return [self computeInputStatusForBillingCountryInput:(CountryBillingInput *)input];
        case EligibilityInputTypeDeviceClass:
            return [self computeInputStatusForDeviceClassInput:(DeviceClassInput *)input];
        case EligibilityInputTypeDeviceLocale:
            return [self computeInputStatusForDeviceLocaleInput:(DeviceLocaleInput *)input];
        case EligibilityInputTypeChinaCellular:
            return [self computeInputStatusForChinaCellularInput:(ChinaCellularInput *)input];
        case EligibilityInputTypeDeviceRegionCode:
            return [self computeInputStatusForDeviceRegionCodesInput:(DeviceRegionCodeInput *)input];
        case EligibilityInputTypeDeviceLanguage:
            return [self computeInputStatusForDeviceLanguageInput:(DeviceLanguageInput *)input];
        case EligibilityInputTypeGenerativeModelSystem:
            return [self computeInputStatusForGenerativeModelSystemInput:(GenerativeModelSystemInput *)input];
        case EligibilityInputTypeGreyMatterOnQueue:
            return [self computeInputStatusForGreymatterQueueInput:(GreymatterQueueInput *)input];
        case EligibilityInputTypeSiriLanguage:
            return [self computeInputStatusForSiriLanguageInput:(SiriLanguageInput *)input];
        default:
            os_log_error(eligibility_log(), "%s: Unsupported input for %@: %@(%llu)", __func__, self, eligibility_input_to_NSString(inputType), (uint64_t)inputType);
            return EligibilityInputStatusUnspecifiedError;
    }
}

- (BOOL)isInterestedInInput:(EligibilityInputType)inputType {
    EligibilityInputTypes supportedInputs = self.supportedInputs;
    switch (inputType) {
        case EligibilityInputTypeCountryLocation:
            return supportedInputs & EligibilityInputTypesCountryLocation;
        case EligibilityInputTypeCountryBilling:
            return supportedInputs & EligibilityInputTypesCountryBilling;
        case EligibilityInputTypeDeviceClass:
            return supportedInputs & EligibilityInputTypesDeviceClass;
        case EligibilityInputTypeDeviceLocale:
            return supportedInputs & EligibilityInputTypesDeviceLocale;
        case EligibilityInputTypeChinaCellular:
            return supportedInputs & EligibilityInputTypesChinaCellular;
        case EligibilityInputTypeDeviceRegionCode:
            return supportedInputs & EligibilityInputTypesDeviceRegionCode;
        case EligibilityInputTypeDeviceLanguage:
            return supportedInputs & EligibilityInputTypesDeviceLanguage;
        case EligibilityInputTypeGenerativeModelSystem:
            return supportedInputs & EligibilityInputTypesGenerativeModelSystem;
        case EligibilityInputTypeGreyMatterOnQueue:
            return supportedInputs & EligibilityInputTypesGreyMatterOnQueue;
        case EligibilityInputTypeSiriLanguage:
            return supportedInputs & EligibilityInputTypesSiriLanguage;
        default:
            return NO;
    }
}

- (BOOL)hasActiveGracePeriod {
    if (!(self.supportedInputs & EligibilityInputTypesCountryLocation)) {
        return NO;
    }
    EligibilityTimer *timer = self.locatedCountryTimer;
    if (!timer) {
        return NO;
    }
    return timer.isActive;
}

- (EligibilityInputStatus)_computeInputStatusForSet:(NSSet *)set withObject:(id)object isInverted:(BOOL)inverted {
    EligibilityInputStatus containsStatus = inverted ? EligibilityInputStatusNotEligible : EligibilityInputStatusEligible;
    EligibilityInputStatus notContainsStatus = inverted ? EligibilityInputStatusEligible : EligibilityInputStatusNotEligible;
    if (!set) {
        return notContainsStatus;
    }
    if (!object) {
        return EligibilityInputStatusNotSet;
    }
    return [set containsObject:object] ? containsStatus : notContainsStatus;
}

- (EligibilityInputStatus)computeInputStatusForLocatedCountryInput:(LocatedCountryInput *)input {
    EligibilityTimer *timer = self.locatedCountryTimer;
    BOOL inverted = self.invertLocatedCountries;
    EligibilityInputStatus containsStatus = inverted ? EligibilityInputStatusNotEligible : EligibilityInputStatusEligible;
    EligibilityInputStatus notContainsStatus = inverted ? EligibilityInputStatusEligible : EligibilityInputStatusNotEligible;
    if (!self.locatedCountriesOfInterest) {
        return notContainsStatus;
    }
    BOOL intersect = [input.countryCodes intersectsSet:self.locatedCountriesOfInterest];
    if (intersect) {
        [timer reset];
        [timer enable];
        return containsStatus;
    } else {
        [timer resume];
        if (timer) {
            return timer.hasExpired ? notContainsStatus : containsStatus;
        } else {
            return notContainsStatus;
        }
    }
}

- (EligibilityInputStatus)computeInputStatusForBillingCountryInput:(CountryBillingInput *)input {
    return [self _computeInputStatusForSet:self.billingCountriesOfInterest withObject:input.countryCode isInverted:self.invertBillingCountries];
}

- (EligibilityInputStatus)computeInputStatusForDeviceClassInput:(DeviceClassInput *)input {
    return [self _computeInputStatusForSet:self.deviceClassesOfInterest withObject:input.deviceClass isInverted:NO];
}

- (EligibilityInputStatus)computeInputStatusForDeviceLocaleInput:(DeviceLocaleInput *)input {
    return [self _computeInputStatusForSet:self.deviceLocalesOfInterest withObject:input.deviceLocale isInverted:NO];
}

- (EligibilityInputStatus)computeInputStatusForChinaCellularInput:(ChinaCellularInput *)input {
    return input.chinaCellularDevice ? EligibilityInputStatusEligible : EligibilityInputStatusNotEligible;
}

- (EligibilityInputStatus)computeInputStatusForDeviceRegionCodesInput:(DeviceRegionCodeInput *)input {
    return [self _computeInputStatusForSet:self.deviceRegionCodesOfInterest withObject:input.deviceRegionCode isInverted:NO];
}

- (EligibilityInputStatus)computeInputStatusForDeviceLanguageInput:(DeviceLanguageInput *)input {
    NSArray *deviceLanguages = input.deviceLanguages;
    if (!deviceLanguages) {
        return EligibilityInputStatusNotSet;
    }
    NSSet *deviceLanguageSet = [NSSet setWithArray:deviceLanguages];
    if (!deviceLanguageSet) {
        return EligibilityInputStatusNotEligible;
    }
    return [self.deviceLanguagesOfInterest intersectsSet:deviceLanguageSet] ? EligibilityInputStatusEligible : EligibilityInputStatusNotEligible;
}

- (EligibilityInputStatus)computeInputStatusForGenerativeModelSystemInput:(GenerativeModelSystemInput *)input {
    return input.supportsGenerativeModelSystems ? EligibilityInputStatusEligible : EligibilityInputStatusNotEligible;
}

- (EligibilityInputStatus)computeInputStatusForGreymatterQueueInput:(GreymatterQueueInput *)input {
    return input.onGreymatterQueue ? EligibilityInputStatusNotEligible : EligibilityInputStatusEligible;
}

- (EligibilityInputStatus)computeInputStatusForSiriLanguageInput:(SiriLanguageInput *)input {
    os_crash("This property must be overridden");
}

- (NSDictionary *)serialize {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"os_eligibility_answer_t"] = [NSNumber numberWithUnsignedLongLong:self.answer];
    dict[@"os_eligibility_answer_source_t"] = [NSNumber numberWithUnsignedLongLong:self.answerSource];
    dict[@"status"] = self.status;
    dict[@"context"] = self.context;
    return dict.copy;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[NSNumber numberWithUnsignedLongLong:self.answer] forKey:@"answer"];
    [coder encodeObject:self.context forKey:@"context"];
    [coder encodeObject:self.locatedCountryTimer forKey:@"locatedCountryTimer"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _answer = [[coder decodeObjectOfClass:NSNumber.class forKey:@"answer"] unsignedLongLongValue];
        _context = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSDictionary.class, NSString.class, NSNumber.class, NSArray.class, nil]
                                         forKey:@"context"];
        _locatedCountryTimer = [coder decodeObjectOfClass:EligibilityTimer.class forKey:@"locatedCountryTimer"];
    }
    return self;
}

- (EligibilityAnswer)computeAnswerFromStatus:(NSDictionary *)status {
    BOOL hasEligibleStatus = NO;
    BOOL hasNotEligibleOrErrorStatus = NO;
    for (NSNumber *value in status.allValues) {
        EligibilityInputStatus inputStatus = value.unsignedLongLongValue;
        switch (inputStatus) {
            case EligibilityInputStatusNone:
            case EligibilityInputStatusNotSet:
                return EligibilityAnswerNotYetAvailable;
            case EligibilityInputStatusEligible:
                hasEligibleStatus = YES;
            default:
                hasNotEligibleOrErrorStatus = YES;
        }
    }
    if (hasNotEligibleOrErrorStatus) {
        return EligibilityAnswerNotEligible;
    } else if (hasEligibleStatus) {
        return EligibilityAnswerEligible;
    } else {
        return self.defaultAnswer;
    }
}

- (EligibilityAnswer)computeAnswerFromStatusWithError:(NSError * _Nullable *)errorPtr {
    NSDictionary *status = self.status;
    if (!status) {
        os_log_fault(eligibility_log(), "%s: Failed to get status for a computed domain", __func__);
        NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:ENOATTR userInfo:nil];
        if (errorPtr) {
            *errorPtr = error;
        }
        return EligibilityAnswerInvalid;
    }
    self.answer = [self computeAnswerFromStatus:status];
    return EligibilityAnswerNotYetAvailable;
}

- (void)addContextForKey:(NSString *)key value:(id)value {
    NSMutableDictionary *context = nil;
    if (self.context) {
        context = self.context.mutableCopy;
    } else {
        context = [NSMutableDictionary new];
    }
    context[key] = value;
    self.context = context.copy;
}

- (id)copyWithZone:(NSZone *)zone {
    EligibilityDomain *copiedDomain = [[[self class] allocWithZone:zone] init];
    copiedDomain.answer = self.answer;
    copiedDomain.context = [self.context copyWithZone:zone];
    copiedDomain.supportedInputs = self.supportedInputs;
    copiedDomain.locatedCountriesOfInterest = [self.locatedCountriesOfInterest copyWithZone:zone];
    copiedDomain.invertLocatedCountries = self.invertLocatedCountries;
    copiedDomain.billingCountriesOfInterest = [self.billingCountriesOfInterest copyWithZone:zone];
    copiedDomain.invertBillingCountries = self.invertBillingCountries;
    copiedDomain.deviceClassesOfInterest = [self.deviceClassesOfInterest copyWithZone:zone];
    copiedDomain.deviceLocalesOfInterest = [self.deviceLocalesOfInterest copyWithZone:zone];
    copiedDomain.deviceRegionCodesOfInterest = [self.deviceRegionCodesOfInterest copyWithZone:zone];
    copiedDomain.deviceLanguagesOfInterest = [self.deviceLanguagesOfInterest copyWithZone:zone];
    copiedDomain.locatedCountryTimer = [self.locatedCountryTimer copyWithZone:zone];
    return copiedDomain;
}

- (NSUInteger)hash {
    return self.status.hash ^ self.answer
    ^ (self.context.hash ^ self.supportedInputs)
    ^ (self.locatedCountriesOfInterest.hash ^ self.billingCountriesOfInterest.hash ^ self.deviceClassesOfInterest.hash)
    ^ (self.deviceLocalesOfInterest.hash ^ self.deviceLanguagesOfInterest.hash ^ self.locatedCountryTimer.hash ^ self.deviceRegionCodesOfInterest.hash)
    ^ (self.invertLocatedCountries ^ (self.invertBillingCountries ? 2 : 0));
}

- (BOOL)isEqual:(id)other {
    if (![super isEqual:other]) {
        return NO;
    } else if (other == self) {
        return YES;
    } else {
        if (![other isKindOfClass:self.class]) {
            return NO;
        }
        EligibilityDomain *otherDomain = (EligibilityDomain *)other;
        if (self.answer != otherDomain.answer) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "answer");
            return NO;
        } else if (!AreObjectsEqual(self.status, otherDomain.status)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "status");
            return NO;
        } else if (!AreObjectsEqual(self.context, otherDomain.context)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "context");
            return NO;
        } else if (self.supportedInputs != otherDomain.supportedInputs) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "supportedInputs");
            return NO;
        } else if (!AreObjectsEqual(self.locatedCountriesOfInterest, otherDomain.locatedCountriesOfInterest)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "locatedCountriesOfInterest");
            return NO;
        } else if (self.invertLocatedCountries != otherDomain.invertLocatedCountries) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "invertLocatedCountries");
            return NO;
        } else if (!AreObjectsEqual(self.billingCountriesOfInterest, otherDomain.billingCountriesOfInterest)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "billingCountriesOfInterest");
            return NO;
        } else if (self.invertBillingCountries != otherDomain.invertBillingCountries) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "invertBillingCountries");
            return NO;
        } else if (!AreObjectsEqual(self.deviceClassesOfInterest, otherDomain.deviceClassesOfInterest)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "deviceClassesOfInterest");
            return NO;
        } else if (!AreObjectsEqual(self.deviceLocalesOfInterest, otherDomain.deviceLocalesOfInterest)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "deviceLocalesOfInterest");
            return NO;
        } else if (!AreObjectsEqual(self.deviceLanguagesOfInterest, otherDomain.deviceLanguagesOfInterest)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "deviceLanguagesOfInterest");
            return NO;
        } else if (!AreObjectsEqual(self.locatedCountryTimer, otherDomain.locatedCountryTimer)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "locatedCountryTimer");
            return NO;
        } else if (!AreObjectsEqual(self.deviceRegionCodesOfInterest, otherDomain.deviceRegionCodesOfInterest)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "deviceRegionCodesOfInterest");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)_supportedInputsString {
    EligibilityInputTypes types = self.supportedInputs;
    
    char countryLocation;
    if (types & EligibilityInputTypesCountryLocation) {
        countryLocation = self.locatedCountryTimer ? 'L' : 'l';
    } else {
        countryLocation = '_';
    }
    char billingCountry;
    if (types & EligibilityInputTypesCountryBilling) {
        billingCountry = 'B';
    } else {
        billingCountry = '_';
    }
    char deviceClass;
    if (types & EligibilityInputTypesDeviceClass) {
        deviceClass = 'D';
    } else {
        deviceClass = '_';
    }
    char deviceLocale;
    if (types & EligibilityInputTypesDeviceLocale) {
        deviceLocale = 'R';
    } else {
        deviceLocale = '_';
    }
    char chinaCellular;
    if (types & EligibilityInputTypesChinaCellular) {
        chinaCellular = 'C';
    } else {
        chinaCellular = '_';
    }
    char deviceRegionCode;
    if (types & EligibilityInputTypesDeviceRegionCode) {
        deviceRegionCode = 'S';
    } else {
        deviceRegionCode = '_';
    }
    char deviceLanguage;
    if (types & EligibilityInputTypesDeviceLanguage) {
        deviceLanguage = 'T';
    } else {
        deviceLanguage = '_';
    }
    char generativeModelSystem;
    if (types & EligibilityInputTypesGenerativeModelSystem) {
        generativeModelSystem = 'M';
    } else {
        generativeModelSystem = '_';
    }
    char greymatterQueue;
    if (types & EligibilityInputTypesGreyMatterOnQueue) {
        greymatterQueue = 'Q';
    } else {
        greymatterQueue = '_';
    }
    char siriLanguage;
    if (types & EligibilityInputTypesSiriLanguage) {
        siriLanguage = 'A';
    } else {
        siriLanguage = '_';
    }
    return [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c%c%c", 
            countryLocation, billingCountry, deviceClass, deviceLocale,
            chinaCellular, deviceRegionCode, deviceLanguage, generativeModelSystem,
            greymatterQueue, siriLanguage];
}

- (NSString *)_interestedDataString {
    EligibilityInputTypes supportedInputs = self.supportedInputs;
    NSString *countryLocationString;
    if (supportedInputs & EligibilityInputTypesCountryLocation) {
        countryLocationString = [NSString stringWithFormat:@"locatedCountries: %@ gracePeriod: %@ inverted: %@", 
                                 self.locatedCountriesOfInterest.description,
                                 self.locatedCountryTimer.description ?: @"<NULL>",
                                 self.invertLocatedCountries ? @"Y" : @"N"];
    } else {
        countryLocationString = @"";
    }
    NSString *billingCountryString;
    if (supportedInputs & EligibilityInputTypesCountryBilling) {
        billingCountryString = [NSString stringWithFormat:@"billingCountries: %@ inverted: %@", 
                                self.billingCountriesOfInterest.description,
                                self.invertBillingCountries ? @"Y" : @"N"];
    } else {
        billingCountryString = @"";
    }
    NSString *deviceClassString;
    if (supportedInputs & EligibilityInputTypesDeviceClass) {
        deviceClassString = [NSString stringWithFormat:@"deviceClasses: %@",
                             self.deviceClassesOfInterest.description];
    } else {
        deviceClassString = @"";
    }
    NSString *deviceLocaleString;
    if (supportedInputs & EligibilityInputTypesDeviceLocale) {
        deviceLocaleString = [NSString stringWithFormat:@"deviceLocales: %@",
                              self.deviceLocalesOfInterest.description];
    } else {
        deviceLocaleString = @"";
    }
    NSString *chinaCellularString;
    if (supportedInputs & EligibilityInputTypesChinaCellular) {
        chinaCellularString = @"chinaCellular: Y";
    } else {
        chinaCellularString = @"";
    }
    NSString *deviceRegionCodeString;
    if (supportedInputs & EligibilityInputTypesDeviceRegionCode) {
        deviceRegionCodeString = [NSString stringWithFormat:@"regionCodes: %@",
                                  self.deviceRegionCodesOfInterest.description];
    } else {
        deviceRegionCodeString = @"";
    }
    NSString *deviceLanguageString;
    if (supportedInputs & EligibilityInputTypesDeviceLanguage) {
        deviceLanguageString = [NSString stringWithFormat:@"deviceLanguages: %@",
                                self.deviceLanguagesOfInterest.description];
    } else {
        deviceLanguageString = @"";
    }
    NSString *generativeModelSystemString;
    if (supportedInputs & EligibilityInputTypesGenerativeModelSystem) {
        generativeModelSystemString = @"generativeModelSystem: Y";
    } else {
        generativeModelSystemString = @"";
    }
    NSString *greymatterQueueString;
    if (supportedInputs & EligibilityInputTypesGreyMatterOnQueue) {
        greymatterQueueString = @"greymatterQueue: Y";
    } else {
        greymatterQueueString = @"";
    }
    NSString *siriLanguageString;
    if (supportedInputs & EligibilityInputTypesSiriLanguage) {
        siriLanguageString = @"siriLanguage: Y";
    } else {
        siriLanguageString = @"";
    }
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@",
            countryLocationString, billingCountryString, deviceClassString, deviceLocaleString,
            chinaCellularString, deviceRegionCodeString, deviceLanguageString, generativeModelSystemString,
            greymatterQueueString, siriLanguageString];
    
    return nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Domain: %s(%llu)>(%@) - <answer: %@, source: %@, context: %@, status: %@> - <%@>>",
            eligibility_domain_to_str(self.domain),
            (uint64_t)self.domain,
            self._supportedInputsString,
            eligibility_answer_to_NSString(self.answer),
            eligibility_answer_source_to_NSString(self.answerSource),
            self.context,
            self.status,
            self._interestedDataString];
}

@end
