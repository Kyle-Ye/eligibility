//
//  LocatedCountryInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/19.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "LocatedCountryInput.h"
#import "EligibilityLog.h"
#import "EligibilityBase.h"
#import "XPCSPI.h"

@implementation LocatedCountryInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCountryCodes:(nullable xpc_object_t)xpcCountryCodes
                              status:(EligibilityInputStatus)status
                             process:(nullable NSString *)process {
    NSSet *countryCodes;
    if (xpcCountryCodes != nil) {
        xpc_type_t type = xpc_get_type(xpcCountryCodes);
        if (type != XPC_TYPE_ARRAY) {
            os_log_error(eligibility_log(), "%s: Located country codes input is wrong data type: %s", __func__, xpc_type_get_name(type));
            return nil;
        }
        countryCodes = [NSSet setWithArray:(__bridge NSArray*)_CFXPCCreateCFObjectFromXPCObject(xpcCountryCodes)];
    } else {
        countryCodes = nil;
    }
    self = [super initWithInputType:EligibilityInputTypeCountryLocation status:status process:process];
    if (self) {
        self.countryCodes = countryCodes;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.countryCodes forKey:@"countryCodes"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.countryCodes = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSSet.class, NSString.class, nil] 
                                                  forKey:@"countryCodes"];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    LocatedCountryInput *copiedInput = [super copyWithZone:zone];
    copiedInput.countryCodes = [self.countryCodes copyWithZone:zone];
    return copiedInput;
}

- (NSUInteger)hash {
    return [self.countryCodes hash] ^ [super hash];
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
        LocatedCountryInput *otherInput = (LocatedCountryInput *)other;
        if (!AreObjectsEqual(self.countryCodes, otherInput.countryCodes)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "countryCodes");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[LocatedCountryInput countryCodes:%@ %@]", self.countryCodes, [super description]];
}

@end
