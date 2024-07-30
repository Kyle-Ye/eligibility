//
//  NSLocale+Private.h
//  eligibility
//
//  Created by Kyle on 2024/7/31.
//

#ifndef NSLocale_Private_h
#define NSLocale_Private_h

#import <Foundation/Foundation.h>

@interface NSLocale (EligibilityPrivate)
+ (NSArray *)systemLanguages;
- (BOOL)isEquivalentTo:(NSLocale *)locale API_AVAILABLE(macos(13.0), ios(16.0), watchos(9.0), tvos(16.0));
@end

#endif /* NSLocale_Private_h */
