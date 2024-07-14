//
//  BackgroundSystemTasks.h
//  eligibilityd
//
//  Created by Kyle on 2024/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGSystemTask : NSObject
@property (copy, readonly) NSString *identifier;
@property (nullable, strong) void (^expirationHandler)(void);
- (instancetype)init NS_UNAVAILABLE; // Subclasses of this abstract type are created by the system and cannot be directly instantiated
+ (instancetype)new NS_UNAVAILABLE; // Subclasses of this abstract type are created by the system and cannot be directly instantiated
@end

@interface BGSystemTaskScheduler : NSObject
- (instancetype)init NS_UNAVAILABLE; //Use the shared scheduler object instead
+ (instancetype)new NS_UNAVAILABLE; //Use the shared scheduler object instead

/// The shared background task scheduler instance.
@property (class, readonly, strong) __kindof BGSystemTaskScheduler *sharedScheduler;

- (BOOL)registerForTaskWithIdentifier:(NSString *)identifier usingQueue:(nullable dispatch_queue_t)queue launchHandler:(void (^)(__kindof BGSystemTask *task))launchHandler NS_EXTENSION_UNAVAILABLE("Only the host application may register launch handlers");

@end

NS_ASSUME_NONNULL_END
