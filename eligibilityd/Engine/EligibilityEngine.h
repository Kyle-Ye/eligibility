//
//  EligibilityEngine.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "EligibilityOverride.h"

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityEngine : NSObject

@property (nonatomic, retain) NSDictionary *domains;
@property (nonatomic, retain) NSMutableSet *notificationsToSend;
@property (nonatomic, retain) EligibilityOverride *eligibilityOverrides;
@property (nonatomic, retain) NSObject<OS_dispatch_queue> *internalQueue;

+ (instancetype)sharedInstance;
- (instancetype)init;

- (void)recomputeAllDomainAnswers;

@end

NS_ASSUME_NONNULL_END
