//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#include "EligibilityCore.h"
#include "XPCSPI.h"
#include "Helper.h"
#include <xpc/xpc.h>

#if __has_include("os_eligibility")
#include "os_eligibility.h"
#else

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
int os_eligibility_force_domain_set_answers(EligibilityDomainTypes domainSet, EligibilityAnswer answer, xpc_object_t _Nullable context);
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

#endif
