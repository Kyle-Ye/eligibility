//
//  BoronAsset.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "BoronAsset.h"
#import "EligibilityLog.h"
#import "EligibilityBase.h"

@implementation BoronAsset

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        id boron = dict[@"Boron"];
        if (boron) {
            NSArray *countryCodes = [boron objectForKey:@"Country Codes"];
            if (countryCodes && [countryCodes isKindOfClass:NSArray.class]) {
                self.countryCodes = [NSSet setWithArray:countryCodes];
            } else {
                os_log_error(eligibility_log(), "%s: Mobile Asset is missing key \\\"%@\\\" of NSArray type", "-[BoronAsset initWithDictionary:]", @"Country Codes");
            }
            NSNumber *gracePeriod = [boron objectForKey:@"Grace Period"];
            if (gracePeriod && [gracePeriod isKindOfClass:NSNumber.class]) {
                self.gracePeriodInSeconds = gracePeriod.unsignedIntegerValue;
            } else {
                os_log_error(eligibility_log(), "%s: Mobile Asset is missing key \\\"%@\\\" of NSNumber type", "-[BoronAsset initWithDictionary:]", @"Grace Period");
            }
        } else {
            os_log_error(eligibility_log(), "%s: Mobile Asset does not contain the Boron domain", "-[BoronAsset initWithDictionary:]");
        }
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone { 
    BoronAsset *asset = [[self class] allocWithZone:zone];
    BoronAsset *copiedAsset = [self init];
    copiedAsset.countryCodes = [asset.countryCodes copyWithZone:zone];
    copiedAsset.gracePeriodInSeconds = asset.gracePeriodInSeconds;
    return copiedAsset;
}

- (NSUInteger)hash {
    return self.countryCodes.hash ^ self.gracePeriodInSeconds;
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
        BoronAsset *otherAsset = (BoronAsset *)other;
        if (!AreObjectsEqual(self.countryCodes, otherAsset.countryCodes)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "countryCodes");
            return NO;
        } else if (self.gracePeriodInSeconds != otherAsset.gracePeriodInSeconds) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "gracePeriodInSeconds");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[Boron Asset countryCodes:%@ gracePeriod:%lu]", self.countryCodes, self.gracePeriodInSeconds];
}

@end
