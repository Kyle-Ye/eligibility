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

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityEngine : NSObject

@property (nonatomic, retain) NSDictionary<NSString *, __kindof EligibilityDomain *> *domains;
@property (nonatomic, retain) NSMutableSet<NSNotificationName> *notificationsToSend;
@property (nonatomic, retain) EligibilityOverride *eligibilityOverrides;
@property (nonatomic, retain) NSObject<OS_dispatch_queue> *internalQueue;

+ (instancetype)sharedInstance;
- (instancetype)init;

- (void)recomputeAllDomainAnswers;
- (void)resetDomain:(NSString *)domain withError:(NSError **)error;
- (void)resetAllDomainsWithError:(NSError **)error;
- (NSDictionary *)internalStateWithError:(NSError **)error;

- (void)scheduleDailyRecompute;

@end

NS_ASSUME_NONNULL_END
