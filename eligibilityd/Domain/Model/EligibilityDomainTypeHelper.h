//
//  EligibilityDomainTypeHelper.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import <Foundation/Foundation.h>
#import "EligibilityDomainType.h"

NS_ASSUME_NONNULL_BEGIN

NSString *eligibility_domain_to_NSString(EligibilityDomainType domain);
const char *eligibility_plist_path_for_domain(EligibilityDomainType domain);

NS_ASSUME_NONNULL_END
