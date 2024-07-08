//
//  EligibilityUtils.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/24.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <xpc/xpc.h>

NS_ASSUME_NONNULL_BEGIN

void asyncBlock(dispatch_queue_t queue, dispatch_block_t block);
const char *copy_eligibility_domain_data_vault_directory_path(void);
const char *copy_eligibility_domain_daemon_directory_path(void);
const char * copy_eligibility_domain_input_manager_plist_path(void);
const char * copy_eligibility_domain_domains_serialization_path(void);
uint64_t eligibility_xpc_get_message_type(xpc_object_t object);

NSURL * _Nullable OEURLForContainerWithError(NSError * _Nullable *errorPtr);

NS_ASSUME_NONNULL_END
