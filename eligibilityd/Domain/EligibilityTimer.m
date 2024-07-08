//
//  EligibilityTimer.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityTimer.h"
#import "EligibilityLog.h"
#import "EligibilityDefine.h"

@interface EligibilityTimer ()

@property(nonatomic, assign) BOOL enabled;
@property(nonatomic, assign) NSUInteger loadedTimeInSeconds;
@property(nonatomic, strong, nullable) NSDate* timeStart;

@end

@implementation EligibilityTimer

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithSeconds:(NSUInteger)seconds {
    self = [super init];
    if (self) {
        self.loadedTimeInSeconds = seconds;
        self.timeStart = nil;
    }
    return self;
}


- (void)setDurationWithSeconds:(NSUInteger)seconds {
    _loadedTimeInSeconds = seconds;
}

- (void)enable {
    self.enabled = YES;
}

- (void)resume {
    if (!self.enabled) {
        return;
    }
    if (self.timeStart) {
        return;
    }
    self.timeStart = NSDate.now;
}

- (void)reset {
    self.timeStart = nil;
}

- (BOOL)hasExpired {
    if (!self.enabled) {
        return YES;
    }
    NSDate *timeStart = self.timeStart;
    if (!timeStart) {
        return YES;
    }
    return -timeStart.timeIntervalSinceNow >= self.loadedTimeInSeconds;
}

- (BOOL)isActive {
    if (!self.enabled) {
        return NO;
    }
    if (!self.timeStart) {
        return NO;
    }
    return !self.hasExpired;
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
        EligibilityTimer *otherTimer = (EligibilityTimer *)other;
        if (self.loadedTimeInSeconds != otherTimer.loadedTimeInSeconds) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "loadedTimeInSeconds");
            return NO;
        } else if (!AreObjectsEqual(self.timeStart, otherTimer.timeStart)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "timeStart");
            return NO;
        } else if (self.enabled != otherTimer.enabled) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "setTime");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSUInteger)hash {
    return [self.timeStart hash] ^ self.loadedTimeInSeconds ^ self.enabled;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:[NSNumber numberWithUnsignedInteger:self.loadedTimeInSeconds] forKey:@"loadedTimeInSeconds"];
    [coder encodeObject:self.timeStart forKey:@"timeStart"];
    [coder encodeBool:self.enabled forKey:@"enabled"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self) {
        _loadedTimeInSeconds = [[coder decodeObjectOfClass:NSNumber.class forKey:@"loadedTimeInSeconds"] unsignedIntegerValue];
        _timeStart = [coder decodeObjectOfClass:NSDate.class forKey:@"timeStart"];
        _enabled = [coder decodeBoolForKey:@"enabled"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    EligibilityTimer *copiedTimer = [[[self class] allocWithZone:zone] init];
    copiedTimer.loadedTimeInSeconds = self.loadedTimeInSeconds;
    copiedTimer.timeStart = [self.timeStart copyWithZone:zone];
    copiedTimer.enabled = self.enabled;
    return copiedTimer;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Timer loadedTime: %lu(seconds), timeStart: %@, enabled: %@>", self.loadedTimeInSeconds, self.timeStart, self.enabled ? @"Y" : @"N"];
}

@end
