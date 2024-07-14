//
//  EligibilityEngine.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "EligibilityOverride.h"
#import "EligibilityDomain.h"
#import "EligibilityDomainType.h"
#import "EligibilityDomainTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityEngine : NSObject

@property (nonatomic, retain) NSDictionary<NSString *, __kindof EligibilityDomain *> *domains;
@property (nonatomic, retain) NSMutableSet<NSNotificationName> *notificationsToSend;
@property (nonatomic, retain) EligibilityOverride *eligibilityOverrides;
@property (nonatomic, retain) NSObject<OS_dispatch_queue> *internalQueue;

+ (instancetype)sharedInstance;
- (instancetype)init;

- (void)recomputeAllDomainAnswers;
- (BOOL)setInput:(EligibilityInputType)input to:(xpc_object_t)object status:(EligibilityInputStatus)status fromProcess:(nullable NSString *)process withError:(NSError **)errorPtr;
- (void)resetDomain:(NSString *)domain withError:(NSError **)errorPtr;
- (void)resetAllDomainsWithError:(NSError **)errorPtr;
- (void)forceDomainAnswer:(EligibilityDomainType)domain answer:(EligibilityAnswer)answer context:(xpc_object_t _Nullable)context withError:(NSError **)errorPtr;
- (void)forceDomainSetAnswers:(EligibilityDomainTypes)domainSet answer:(EligibilityAnswer)answer context:(xpc_object_t _Nullable)context withError:(NSError **)errorPtr;
- (NSDictionary *)internalStateWithError:(NSError **)errorPtr;
- (NSDictionary *)stateDumpWithError:(NSError **)errorPtr;
- (BOOL)dumpToDirectory:(NSURL *)directory withError:(NSError **)errorPtr;
- (void)asyncUpdateAndRecomputeAllAnswers;
- (void)scheduleDailyRecompute;

@end

NS_ASSUME_NONNULL_END
