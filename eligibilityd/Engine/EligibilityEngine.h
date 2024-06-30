//
//  EligibilityEngine.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EligibilityEngine : NSObject

@property (nonatomic, retain) NSArray *domains;
@property (nonatomic, retain) NSArray *notificationsToSend;
@property (nonatomic, retain) NSArray *eligibilityOverrides;
@property (nonatomic, retain) NSObject *internalQueue;

+ (instancetype)sharedInstance;
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
