//
//  EligibilityOverrideData.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/30.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#import "EligibilityOverrideData.h"
#import "EligibilityLog.h"
#import "EligibilityDefine.h"

@interface EligibilityOverrideData ()

@property(nonatomic, assign) EligibilityAnswer answer;
@property(nonatomic, strong, nullable) NSDictionary *context;

@end

@implementation EligibilityOverrideData

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithAnswer:(EligibilityAnswer)answer context:(nullable NSDictionary *)context {
    self = [super init];
    if (self) {
        self.answer = answer;
        self.context = context;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[NSNumber numberWithUnsignedLongLong:self.answer] forKey:@"answer"];
    [coder encodeObject:self.context forKey:@"context"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _answer = [[coder decodeObjectOfClass:NSNumber.class forKey:@"answer"] unsignedIntegerValue];
        _context = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSDictionary.class, NSString.class, NSNumber.class, nil] forKey:@"context"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    EligibilityOverrideData *copiedData = [[[self class] allocWithZone:zone] init];
    copiedData.answer = self.answer;
    copiedData.context = [self.context copyWithZone:zone];
    return copiedData;
}

- (NSUInteger)hash {
    return self.context.hash ^ self.answer;
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
        EligibilityOverrideData *otherData = (EligibilityOverrideData *)other;
        if (self.answer != otherData.answer) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "answer");
            return NO;
        } else if (!AreObjectsEqual(self.context, otherData.context)) {
            os_log(eligibility_log(), "%s: Property %s did not match", __func__, "context");
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: answer: %@; context: %@>",
            self.class,
            eligibility_answer_to_NSString(self.answer),
            self.context.description ?: @"<NULL>"];
}

@end
