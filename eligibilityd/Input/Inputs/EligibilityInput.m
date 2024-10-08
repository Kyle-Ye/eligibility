//
//  EligibilityInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityInput.h"
#import "EligibilityLog.h"

@implementation EligibilityInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithInputType:(EligibilityInputType)type status:(EligibilityInputStatus)status process:(NSString * _Nullable)process {
    self = [super init];
    if (self) {
        _type = type;
        _status = status;
        _setTime = NSDate.now;
        _settingProccessName = process;
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder { 
    [coder encodeObject:@(self.type) forKey:@"type"];
    [coder encodeObject:@(self.status) forKey:@"status"];
    [coder encodeObject:self.setTime forKey:@"setTime"];
    [coder encodeObject:self.settingProccessName forKey:@"settingProccessName"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder { 
    self = [super init];
    if (self) {
        _type = [[coder decodeObjectOfClass:NSNumber.class forKey:@"type"] unsignedIntegerValue];
        _status = [[coder decodeObjectOfClass:NSNumber.class forKey:@"status"] unsignedIntegerValue];
        _setTime = [coder decodeObjectOfClass:NSDate.class forKey:@"setTime"];
        _settingProccessName = [coder decodeObjectOfClass:NSString.class forKey:@"settingProccessName"];
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    EligibilityInput *copiedInput = [[[self class] allocWithZone:zone] initWithInputType:self.type 
                                                                                  status:self.status
                                                                                 process:self.settingProccessName];
    copiedInput.setTime = self.setTime;
    return copiedInput;
}

- (NSString *)description {
    uint64_t type = self.type;
    uint64_t status = self.status;    
    return [NSString stringWithFormat:@"<EligibilityInput type: %@ status: %@ setTime: %@ settingProccessName: %@>",
            eligibility_input_to_NSString(type),
            eligibility_input_status_to_str(status) ?: [NSString stringWithFormat:@"<Unknown: %llu>", status],
            self.setTime,
            self.settingProccessName ?: @"<NULL>"];
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
        EligibilityInput *otherInput = (EligibilityInput *)other;
        if (self.type != otherInput.type) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "type");
            return NO;
        } else if (self.status != otherInput.status) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "status");
            return NO;
        } else if (self.setTime != otherInput.setTime) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "setTime");
            return NO;
        } else if (self.settingProccessName != otherInput.settingProccessName) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "settingProccessName");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSUInteger)hash {
    return self.type ^ self.status ^ self.setTime.hash ^ self.settingProccessName.hash;
}

@end
