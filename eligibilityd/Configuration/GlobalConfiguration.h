//
//  GlobalConfiguration.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalConfiguration : NSObject

@property(nonatomic, assign) BOOL testModeEnabled;
@property(nonatomic, strong) dispatch_queue_t testModeQueue;
@property(nonatomic, assign, readonly) BOOL testMode;
@property(nonatomic, assign, readonly) BOOL hasInternalContent;
@property(nonatomic, assign, readonly) BOOL isMemoryConstrainedDevice;
@property(nonatomic, strong, readonly) NSString *currentUsername;

+ (instancetype)sharedInstance;
- (instancetype)init;
- (BOOL)setTestMode:(BOOL)testMode withError:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
