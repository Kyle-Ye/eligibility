//
//  GenerativeModelSystemInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "GenerativeModelSystemInput.h"
#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "MobileGestalt.h"

@interface GenerativeModelSystemInput ()

@property(nonatomic, class, assign, readonly) BOOL _mgSupportsGenerativeModelSystems;

@end

@implementation GenerativeModelSystemInput

+ (BOOL)_mgSupportsGenerativeModelSystems {
    return MGGetBoolAnswer((__bridge CFStringRef)@"DeviceSupportsGenerativeModelSystems");
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init {
    self = [super initWithInputType:EligibilityInputTypeGenerativeModelSystem status:EligibilityInputStatusNone process:@"eligibilityd"];
    if (self) {
        self.supportsGenerativeModelSystems = GenerativeModelSystemInput._mgSupportsGenerativeModelSystems;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
}
    
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithInputType:EligibilityInputTypeGenerativeModelSystem status:EligibilityInputStatusNone process:@"eligibilityd"];
    if (self) {
        self.supportsGenerativeModelSystems = GenerativeModelSystemInput._mgSupportsGenerativeModelSystems;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    GenerativeModelSystemInput *copiedInput = [super copyWithZone:zone];
    copiedInput.supportsGenerativeModelSystems = self.supportsGenerativeModelSystems;
    return copiedInput;
}

- (NSUInteger)hash {
    return self.supportsGenerativeModelSystems ^ [super hash];
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
        GenerativeModelSystemInput *otherInput = (GenerativeModelSystemInput *)other;
        if (self.supportsGenerativeModelSystems != otherInput.supportsGenerativeModelSystems) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "supportsGenerativeModelSystems");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[GenerativeModelSystemInput supportsGenerativeModelSystems:%@ %@]", self.supportsGenerativeModelSystems ? @"Y" : @"N", [super description]];
}

@end
