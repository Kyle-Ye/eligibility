//
//  DeviceLanguageInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "DeviceLanguageInput.h"
#import "GlobalConfiguration.h"

@implementation DeviceLanguageInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (NSArray *)deviceLanguages {
    NSString *username = GlobalConfiguration.sharedInstance.currentUsername;
    if (!username) {
        return nil;
    }
    return (__bridge NSArray *)CFPreferencesCopyValue((__bridge CFStringRef)@"AppleLanguages", kCFPreferencesAnyApplication, (__bridge CFStringRef)username, kCFPreferencesAnyHost);
}

- (instancetype)init {
    return [super initWithInputType:EligibilityInputTypeDeviceLanguage status:EligibilityInputStatusNone process:@"eligibilityd"];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
}
    
- (instancetype)initWithCoder:(NSCoder *)coder {
    return [super initWithCoder:coder];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [super copyWithZone:zone];
}

- (NSUInteger)hash {
    return [super hash];
}

- (BOOL)isEqual:(id)other {
    if (![super isEqual:other]) {
        return NO;
    } else if (other == self) {
        return YES;
    } else {
        return [other isKindOfClass:self.class];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[DeviceLanguageInput deviceLanguages:\\\"%@\\\" %@]", self.deviceLanguages, [super description]];
}

@end
