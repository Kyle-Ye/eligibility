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

@interface EligibilityDomain ()

- (void)_supportedInputsString;

@end

@implementation EligibilityDomain

+(BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - Common API

- (instancetype)init {
    self = [super init];
    if (self) {
        self.answer = EligibilityAnswerInvalid;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        // TODO;
    }
    return self;
}

#pragma mark - Answer Related

- (EligibilityAnswer)defaultAnswer {
    return EligibilityAnswerNotEligible;
}

- (EligibilityAnswerSource)answerSource {
    return EligibilityAnswerSourceComputed;
}

#pragma mark - Status Related

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

- (EligibilityInputStatus)computeInputStatusForInput:(EligibilityInput *)input {
    EligibilityInputType inputType = input.type;
    if (![self isInterestedInInput:inputType]) {
        return EligibilityInputStatusNone;
    }
    switch (inputType) {
        case EligibilityInputTypeCountryLocation:
            // TODO
            return EligibilityInputStatusNotSet;
        default:
            os_log_error(eligibility_log(), "%s: Unsupported input for %@: %@(%llu)", __func__, self, eligibility_input_to_NSString(inputType), (unsigned long long)inputType);
            return EligibilityInputStatusUnspecifiedError;
    }
}



// FIXME: Confirm the logic
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

//- (EligibilityAnswer)computeAnswerFromStatus:(NSDictionary *)status withError:(NSError * _Nullable *)errorPtr {
//    
//}



#pragma mark - Override Methods

//- (EligibilityDomainType)domain {
//    os_crash("This property must be overridden");
//}
//
//- (NSNotificationName)domainChangeNotificationName {
//    os_crash("This property must be overridden");
//}
//
//- (void)updateParameters {
//    os_crash("This method must be overridden");
//}


#pragma mark - Input related

- (void)_supportedInputsString {
    // TOOD
}

- (BOOL)isInterestedInInput:(EligibilityInputType)inputType {
    EligibilityInputType supportedInputs = self.supportedInputs;
    switch (inputType) {
        case EligibilityInputTypeCountryLocation:
            return supportedInputs & (1 << (EligibilityInputTypeCountryLocation - 1));
        case EligibilityInputTypeCountryBilling:
            return supportedInputs & (1 << (EligibilityInputTypeCountryBilling - 1));
        case EligibilityInputTypeDeviceClass:
            return supportedInputs & (1 << (EligibilityInputTypeDeviceClass - 1));
        case EligibilityInputTypeDeviceLocale:
            return supportedInputs & (1 << (EligibilityInputTypeDeviceLocale - 1));
        case EligibilityInputTypeChinaCellular:
            return supportedInputs & (1 << (EligibilityInputTypeChinaCellular - 1));
        case EligibilityInputTypeDeviceRegionCode:
            return supportedInputs & (1 << (EligibilityInputTypeDeviceRegionCode - 1));
        case EligibilityInputTypeDeviceLanguage:
            return supportedInputs & (1 << (EligibilityInputTypeDeviceLanguage - 1));
        case EligibilityInputTypeGenerativeModelSystem:
            return supportedInputs & (1 << (EligibilityInputTypeGenerativeModelSystem - 1));
        case EligibilityInputTypeGreyMatterOnQueue:
            return supportedInputs & (1 << (EligibilityInputTypeGreyMatterOnQueue - 1));
        case EligibilityInputTypeSiriLanguage:
            return supportedInputs & (1 << (EligibilityInputTypeSiriLanguage - 1));
        default:
            return NO;
    }
}

- (void)resetInputsOfInterest {
    // TODO
}
@end
