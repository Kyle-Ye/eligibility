//
//  os_eligibility.h
//  system_eligibility
//
//  Created by Kyle on 2024/7/2.
//  Audited for RELEASE_2024_BETA_1
//  Status: WIP

#ifndef os_eligibility_h
#define os_eligibility_h

#include "EligibilityBase.h"
#include "EligibilityDomainType.h"
#include "EligibilityDomainSet.h"
#include "EligibilityInputType.h"
#include "EligibilityInputTypes.h"
#include "EligibilityInputStatus.h"
#include "EligibilityAnswer.h"
#include "EligibilityAnswerSource.h"
#include "xpc/xpc.h"

ELIGIBILITY_ASSUME_NONNULL_BEGIN

ELIGIBILITY_EXPORT
EligibilityDomainType os_eligibility_domain_for_name(const char * _Nullable name) ELIGIBILITY_SWIFT_NAME(EligibilityDomainType.init(name:));
ELIGIBILITY_EXPORT
const char * _Nullable os_eligibility_get_domain_notification_name(EligibilityDomainType domain);

ELIGIBILITY_EXPORT
int os_eligibility_set_input(EligibilityInputType input, xpc_object_t _Nullable value, EligibilityInputStatus status);
ELIGIBILITY_EXPORT
int os_eligibility_reset_domain(EligibilityDomainType domain);
ELIGIBILITY_EXPORT
int os_eligibility_force_domain_answer(EligibilityDomainType domain, EligibilityAnswer answer, xpc_object_t _Nullable context);
ELIGIBILITY_EXPORT
int os_eligibility_get_internal_state(xpc_object_t _Nullable * _Nullable internal_state_ptr);
ELIGIBILITY_EXPORT
int os_eligibility_reset_all_domains(void);
ELIGIBILITY_EXPORT
int os_eligibility_force_domain_set_answers(EligibilityDomainSet domainSet, EligibilityAnswer answer, xpc_object_t _Nullable context);
ELIGIBILITY_EXPORT
int os_eligibility_get_state_dump(xpc_object_t _Nullable * _Nullable state_dump_dictionary_ptr);
ELIGIBILITY_EXPORT
int os_eligibility_dump_sysdiagnose_data_to_dir(const char* dir_path);
ELIGIBILITY_EXPORT
int os_eligibility_set_test_mode(bool enabled);

ELIGIBILITY_EXPORT
int os_eligibility_get_domain_answer(EligibilityDomainType domain, EligibilityAnswer * _Nullable answer_ptr, EligibilityAnswerSource * _Nullable answer_source_ptr, xpc_object_t _Nullable * _Nullable status_ptr, xpc_object_t _Nullable * _Nullable context_ptr);

ELIGIBILITY_EXPORT
int os_eligibility_get_all_domain_answers(xpc_object_t _Nullable * _Nullable answers_ptr);

ELIGIBILITY_ASSUME_NONNULL_END

#endif /* os_eligibility_h */
