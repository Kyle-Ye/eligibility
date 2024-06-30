//
//  SiriLanguageInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "SiriLanguageInput.h"
#import "GlobalConfiguration.h"

@implementation SiriLanguageInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (NSString *)languages {
    NSString *username = GlobalConfiguration.sharedInstance.currentUsername;
    if (!username) {
        return nil;
    }
    return (__bridge NSString *)CFPreferencesCopyValue((__bridge CFStringRef)@"Session Language", (__bridge CFStringRef)@"com.apple.assistant.backedup", (__bridge CFStringRef)username, kCFPreferencesAnyHost);
}

- (instancetype)init {
    return [super initWithInputType:EligibilityInputTypeSiriLanguage status:EligibilityInputStatusNone process:@"eligibilityd"];
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
    return [NSString stringWithFormat:@"[SiriLanguageInput language:\\\"%@\\\" %@]", self.language, [super description]];
}

@end
