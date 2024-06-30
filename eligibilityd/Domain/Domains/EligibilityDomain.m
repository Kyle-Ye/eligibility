//
//  EligibilityDomain.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import "EligibilityDomain.h"
#import "os_private.h"
#import "InputManager.h"
#import "EligibilityLog.h"
#import "EligibilityTimer.h"

@interface EligibilityDomain ()

@property(nonatomic, strong) EligibilityTimer *locatedCountryTimer;

- (void)_supportedInputsString;
- (EligibilityInputStatus)_computeInputStatusForSet:(NSSet *)set withObject:(id)object isInverted:(BOOL)inverted;

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

- (void)setLocatedCountriesOfInterest:(NSSet *)locatedCountriesOfInterest isInverted:(BOOL)inverted {
    if (locatedCountriesOfInterest) {
        self.supportedInputs |= EligibilityInputTypesCountryLocation;
    } else {
        self.supportedInputs &= ~EligibilityInputTypesCountryLocation;
    }
    _locatedCountriesOfInterest = locatedCountriesOfInterest;
    _invertLocatedCountries = inverted;
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
            os_log_error(eligibility_log(), "%s: Unsupported input for %@: %@(%llu)", __func__, self, eligibility_input_to_NSString(inputType), (unsigned long long)inputType);
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
    // TODO
    return NO;
}

- (EligibilityInputStatus)_computeInputStatusForSet:(NSSet *)set withObject:(NSString *)object isInverted:(BOOL)inverted {
    // TODO
    return EligibilityInputStatusNone;
}

- (EligibilityInputStatus)computeInputStatusForLocatedCountryInput:(LocatedCountryInput *)input {
    // TODO
    return EligibilityInputStatusNone;
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

- (void)serialize {
    // TODO
}

- (void)encodeWithCoder:(NSCoder *)coder {
    // TODO
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    // TODO
    return self;
}

// FIXME: TO BE AUDITED
- (EligibilityAnswer)computeAnswerFromStatus:(NSDictionary *)status {
    if (status.count == 0) {
        return self.defaultAnswer;
    }
    BOOL hasMaybeValue = NO;
    BOOL otherCase = 0;
    for (NSNumber *value in status.allValues) {
        switch (value.unsignedLongLongValue) {
            case EligibilityAnswerInvalid:
            case EligibilityAnswerNotYetAvailable:
                return EligibilityAnswerNotYetAvailable;
            case EligibilityAnswerMaybe:
                hasMaybeValue = YES;
            default:
                otherCase = YES;
        }
    }
    if (otherCase || hasMaybeValue) {
        return otherCase ? EligibilityAnswerNotEligible : EligibilityAnswerEligible;
    } else {
        return self.defaultAnswer;
    }
}

- (EligibilityAnswer)computeAnswerFromStatusWithError:(NSError * _Nullable *)errorPtr {
    // TODO
    return EligibilityAnswerInvalid;
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


//- (void)_supportedInputsString {
//    // TOOD
//}
//
//- (void)resetInputsOfInterest {
//    // TODO
//}

@end
