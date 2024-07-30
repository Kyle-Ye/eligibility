//
//  GreymatterDomain.m
//  eligibilityd
//
//  Created by Kyle on 2024/7/30.
//  Audited for RELEASE_2024_1_BETA_1
//  Status: Complete

#import "GreymatterDomain.h"
#import "MobileAssetManager.h"
#import "NSLocale+Private.h"
#import "BoronAsset.h"

@interface GreymatterDomain ()
- (void)_internal_doInit;
- (BOOL)_equivalentLocale:(NSLocale *)locale isPresentInArray:(NSArray *)array;
- (BOOL)_checkDeviceLanguage:(NSString *)deviceLanguage siriLanguage:(NSString *)siriLanguage;
@end

@implementation GreymatterDomain

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (EligibilityDomainType)domain {
    return EligibilityDomainTypeGreymatter;
}

- (NSNotificationName)domainChangeNotificationName {
    return @"com.apple.os-eligibility-domain.change.greymatter";
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

- (void)updateParameters {
    [self setGenerativeModelSystemVersionInterest];
    [self setDeviceRegionInterest];
    [self setSiriLanguageInterest];
    [self setDeviceLanguageInterest];
    [self setExternalBootInterest];
    [self setDeviceLocalesOfInterest:[NSSet setWithObject:@"US"]];
    // TODO: asset = MobileAssetManager.sharedInstance.greymatterAsset
    BoronAsset *asset = nil;
    [self setLocatedCountriesOfInterest:asset.countryCodes withGracePeriod:asset.gracePeriodInSeconds isInverted:YES];
    return;
}

- (BOOL)_equivalentLocale:(NSLocale *)locale isPresentInArray:(NSArray *)array {
    for (NSString *identifier in array) {
        NSLocale *otherLocale = [[NSLocale alloc] initWithLocaleIdentifier:identifier];
        if ([otherLocale isEquivalentTo:locale]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)_checkDeviceLanguage:(NSString *)deviceLanguage siriLanguage:(NSString *)siriLanguage {
    if (![deviceLanguage hasPrefix:@"en"]) {
        return NO;
    }
    if (![siriLanguage hasPrefix:@"en"]) {
        return NO;
    }
    NSLocale *deviceLocale = [[NSLocale alloc] initWithLocaleIdentifier:deviceLanguage];
    NSLocale *siriLocale = [[NSLocale alloc] initWithLocaleIdentifier:siriLanguage];
    return ![self _equivalentLocale:deviceLocale isPresentInArray:@[@"en-IN", @"en-SG"]] && [self _equivalentLocale:deviceLocale isPresentInArray:@[@"en-US"]] && [deviceLocale isEquivalentTo:siriLocale];
}


- (EligibilityInputStatus)computeInputStatusForDeviceRegionCodesInput:(DeviceRegionCodeInput *)input {
    return input.isChinaSKU ? EligibilityInputStatusNotEligible : EligibilityInputStatusEligible;
}

- (EligibilityInputStatus)computeInputStatusForDeviceLanguageInput:(DeviceLanguageInput *)input {
    NSString *primaryLanguage = input.primaryLanguage;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:primaryLanguage];
    if ([self _equivalentLocale:locale isPresentInArray:@[@"en-US"]]) {
        [self addContextForKey:@"OS_ELIGIBILITY_CONTEXT_ELIGIBLE_DEVICE_LANGUAGES" value: @[primaryLanguage]];
        return EligibilityInputStatusEligible;

    } else {
        [self addContextForKey:@"OS_ELIGIBILITY_CONTEXT_ELIGIBLE_DEVICE_LANGUAGES" value:nil];
        return EligibilityInputStatusNotEligible;
    }
}

- (EligibilityInputStatus)computeInputStatusForSiriLanguageInput:(SiriLanguageInput *)input {
    NSString *language = input.language;
    if (!language) {
        return EligibilityInputStatusEligible;
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:language];
    return [self _equivalentLocale:locale isPresentInArray:@[@"en-US"]] ? EligibilityInputStatusEligible : EligibilityInputStatusNotEligible;
}

@end
