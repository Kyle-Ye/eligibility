//
//  EligibilityOverride.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityOverride.h"
#import "EligibilityOverrideData.h"
#import "EligibilityLog.h"
#import "EligibilityDefine.h"

@interface EligibilityOverride ()

@property(nonatomic, strong) NSMutableDictionary *overrideMap;

@end

@implementation EligibilityOverride

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _overrideMap = [NSMutableDictionary new];
    }
    return self;
}

- (void)forceDomain:(EligibilityDomainType)domain answer:(EligibilityAnswer)answer context:(nullable NSDictionary *)context {
    NSString *domainString = eligibility_domain_to_NSString(domain);
    EligibilityOverrideData *data = [[EligibilityOverrideData alloc] initWithAnswer:answer context:context];
    self.overrideMap[domainString] = data;
}

- (void)resetAnswerForDomain:(EligibilityDomainType)domain {
    [self.overrideMap removeObjectForKey:eligibility_domain_to_NSString(domain)];
}

- (void)resetAllAnswers {
    _overrideMap = [NSMutableDictionary new];
}

- (NSDictionary *)overrideResultDictionaryForDomain:(EligibilityDomainType)domain {
    NSString *domainString = eligibility_domain_to_NSString(domain);
    EligibilityOverrideData *data = self.overrideMap[domainString];
    if (!data) {
        return nil;
    }
    if (data.context) {
        return @{
            @"os_eligibility_answer_source_t": @(data.answer),
            @"context": data.context,
        };

    } else {
        return @{
            @"os_eligibility_answer_source_t": @(data.answer)
        };
    }
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.overrideMap forKey:@"overrideMap"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        NSMutableDictionary *overrideMap = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSDictionary.class, NSString.class, EligibilityOverrideData.class, nil] forKey:@"overrideMap"];
        if (!overrideMap) {
            os_log_error(eligibility_log(), "%s: Failed to deserialize overrideMap, setting to default value", __func__);
            overrideMap = [NSMutableDictionary new];
        }
        _overrideMap = overrideMap;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    EligibilityOverride *copiedOverride = [[[self class] allocWithZone:zone] init];
    copiedOverride.overrideMap = [self.overrideMap copyWithZone:zone];
    return copiedOverride;
}

- (NSUInteger)hash {
    return self.overrideMap.hash;
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
        EligibilityOverride *otherOverride = (EligibilityOverride *)other;
        if (!AreObjectsEqual(self.overrideMap, otherOverride.overrideMap)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "overrideMap");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: overrides: %@>",
            self.class,
            self.overrideMap];
}

@end
