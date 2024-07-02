//
//  os_eligibility.h
//  eligibility
//
//  Created by Kyle on 2024/7/2.
//

#ifndef os_eligibility_h
#define os_eligibility_h

#include <CoreFoundation/CoreFoundation.h>
#include "EligibilityDomainType.h"

CF_ASSUME_NONNULL_BEGIN

EligibilityDomainType os_eligibility_domain_for_name(const char *name);
void os_eligibility_reset_domain(const char *domain);
void os_eligibility_reset_all_domains(void);

CF_ASSUME_NONNULL_END

#endif /* os_eligibility_h */
