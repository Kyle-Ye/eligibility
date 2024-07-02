//
//  containermanager.h
//  eligibilityd
//
//  Created by Kyle on 2024/7/1.
//

#import <Foundation/Foundation.h>
#import <xpc/xpc.h>

extern void *container_query_create(void);
extern void container_query_free(void *);
extern void container_query_set_class(void *query, uint64_t class);
extern void container_query_set_identifiers(void *query, xpc_object_t identifier);
extern const char *CONTAINER_PERSONA_PRIMARY;
extern void container_query_set_persona_unique_string(void *query, const char * str);
extern void container_query_operation_set_flags(void *query, uint64_t flags);
extern void *container_query_get_single_result(void *query);

extern void *container_query_get_last_error(void *query);
extern const char *container_error_copy_unlocalized_description(void *error);
extern int container_error_get_posix_errno(void *error);

extern const char *container_get_path(void *query_result);
