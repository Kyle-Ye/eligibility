//
//  GlobalConfiguration.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "GlobalConfiguration.h"
#import "MobileGestalt.h"
#import "variant_private.h"
#import "EligibilityLog.h"

#import <SystemConfiguration/SystemConfiguration.h>

@implementation GlobalConfiguration

- (BOOL)testMode {
    __block bool enabled = NO;
    dispatch_sync(self.testModeQueue, ^{
        enabled = self.testModeEnabled;
    });
    return enabled;
}

- (BOOL)hasInternalContent {
    static dispatch_once_t onceToken;
    static BOOL hasInternalContent = NO;
    dispatch_once(&onceToken, ^{
        hasInternalContent = os_variant_has_internal_content("com.apple.eligibilityd");
    });
    return hasInternalContent;
}

- (BOOL)isMemoryConstrainedDevice {
    static dispatch_once_t onceToken;
    static BOOL isMemoryConstrainedDevice = NO;
    dispatch_once(&onceToken, ^{
        isMemoryConstrainedDevice = MGGetSInt64Answer((__bridge CFStringRef)@"DeviceMemorySize", 0) < 0x40000001;
    });
    return isMemoryConstrainedDevice;
}

- (NSString *)currentUsername {
    return (__bridge NSString *)SCDynamicStoreCopyConsoleUser(NULL, NULL, NULL);
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalConfiguration *configuration = NULL;
    dispatch_once(&onceToken, ^{
        configuration = [[GlobalConfiguration alloc] init];
    });
    return configuration;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_autorelease_frequency(nil, DISPATCH_AUTORELEASE_FREQUENCY_WORK_ITEM);
        self.testModeQueue = dispatch_queue_create("com.apple.eligibilityd.testMode", attr);
    }
    return self;
}

- (BOOL)setTestMode:(BOOL)testMode withError:(NSError * _Nullable *)error {
    if (!self.hasInternalContent) {
        os_log_error(eligibility_log(), "%s: Test mode can only be set on internal builds", __func__);
        *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EPERM userInfo:nil];
        return NO;
    }
    dispatch_sync(self.testModeQueue, ^{
        self.testModeEnabled = testMode;
    });
    return YES;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<GlobalConfiguration currUser: %@, testMode: %d>", self.currentUsername, self.testMode];
}

@end
