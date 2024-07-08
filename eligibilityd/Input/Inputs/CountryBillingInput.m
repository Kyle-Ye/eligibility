//
//  CountryBillingInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "CountryBillingInput.h"
#import "EligibilityLog.h"
#import "EligibilityDefine.h"
#import "XPCSPI.h"

@implementation CountryBillingInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithBillingCountry:(nullable xpc_object_t)xpcCountry 
                                status:(EligibilityInputStatus)status
                               process:(NSString *)process {
    NSString *countryCode;
    if (xpcCountry != nil) {
        xpc_type_t type = xpc_get_type(xpcCountry);
        if (type != XPC_TYPE_STRING) {
            os_log_error(eligibility_log(), "%s: Billing country code input is wrong data type: %s", __func__, xpc_type_get_name(type));
            return nil;
        }
        countryCode = (__bridge NSString*)_CFXPCCreateCFObjectFromXPCObject(xpcCountry);
    } else {
        countryCode = nil;
    }
    self = [super initWithInputType:EligibilityInputTypeCountryBilling status:status process:process];
    if (self) {
        self.countryCode = countryCode;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.countryCode forKey:@"countryCode"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.countryCode = [coder decodeObjectOfClass:NSString.class
                                               forKey:@"countryCode"];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    CountryBillingInput *copiedInput = [super copyWithZone:zone];
    copiedInput.countryCode = [self.countryCode copyWithZone:zone];
    return copiedInput;
}

- (NSUInteger)hash {
    return [self.countryCode hash] ^ [super hash];
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
        CountryBillingInput *otherInput = (CountryBillingInput *)other;
        if (!AreObjectsEqual(self.countryCode, otherInput.countryCode)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "countryCode");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[CountryBillingInput countryCode:\\\"%@\\\" %@]", self.countryCode, [super description]];
}

@end
