//
//  os_eligibility.h
//  eligibility
//
//  Created by Kyle on 2024/7/2.
//

#ifndef os_eligibility_h
#define os_eligibility_h

#include "EligibilityBase.h"
#include "EligibilityDomainType.h"
#include "EligibilityDomainTypes.h"
#include "EligibilityInputType.h"
#include "EligibilityInputTypes.h"
#include "EligibilityInputStatus.h"
#include "EligibilityAnswer.h"
#include "xpc/xpc.h"

ELIGIBILITY_ASSUME_NONNULL_BEGIN

EligibilityDomainType os_eligibility_domain_for_name(const char *name);
const char * _Nullable os_eligibility_get_domain_notification_name(EligibilityDomainType domain);

int os_eligibility_set_input(EligibilityInputType input, xpc_object_t value, EligibilityInputStatus status);
int os_eligibility_reset_domain(EligibilityDomainType domain);
int os_eligibility_force_domain_answer(EligibilityDomainType domain, EligibilityAnswer answer, xpc_object_t _Nullable context);
int os_eligibility_get_internal_state(xpc_object_t _Nonnull * _Nonnull internal_state_ptr);
int os_eligibility_reset_all_domains(void);
int os_eligibility_force_domain_set_answers(EligibilityDomainTypes domainSet, EligibilityAnswer answer, xpc_object_t context);
int os_eligibility_get_state_dump(xpc_object_t _Nonnull * _Nonnull state_dump_dictionary_ptr);
int os_eligibility_dump_sysdiagnose_data_to_dir(const char* dir_path);
int os_eligibility_set_test_mode(bool enabled);

int os_eligibility_get_domain_answer(EligibilityDomainType domain);
int os_eligibility_get_all_domain_answers(xpc_object_t _Nonnull * _Nullable answers_ptr);

ELIGIBILITY_ASSUME_NONNULL_END

#endif /* os_eligibility_h */
