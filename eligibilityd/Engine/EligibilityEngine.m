//
//  EligibilityEngine.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import "EligibilityEngine.h"
#import "GlobalConfiguration.h"

#import "TestDomain.h"
#import "XcodeLLMDomain.h"

@interface EligibilityEngine ()

- (NSDictionary *)_createDefaultDomains;

@end

@implementation EligibilityEngine

+ (instancetype)sharedInstance {
    static EligibilityEngine *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self class] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // TODO
    }
    return self;
}

- (NSDictionary *)_createDefaultDomains {
    NSDictionary *domains = @{
        eligibility_domain_to_NSString(EligibilityDomainTypeXcodeLLM): [XcodeLLMDomain new],
    }; // TODO: Add more domains
    
    if (GlobalConfiguration.sharedInstance.hasInternalContent) {
        NSMutableDictionary *mutable = domains.mutableCopy;
        mutable[eligibility_domain_to_NSString(EligibilityDomainTypeTest)] = [TestDomain new];
        domains = mutable.copy;
    }
    return domains;
}

@end
