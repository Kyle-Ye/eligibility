//
//  EligibilityInput.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/16.
//

#import "EligibilityInput.h"

@implementation EligibilityInput

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithInputType:(int64_t)type status:(int64_t)status process:(NSString *)process {
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
    EligibilityInput *input = [[self class] allocWithZone:zone];
    EligibilityInput *copiedInput = [self initWithInputType:input.type status:input.status process:input.settingProccessName];
    copiedInput.setTime = input.setTime;
    return copiedInput;
}

@end

//BoronAsset
