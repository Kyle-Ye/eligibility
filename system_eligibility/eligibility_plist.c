//
//  eligibility_plist.c
//  system_eligibility
//
//  Created by Kyle on 2024/7/6.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#include "eligibility_plist.h"
#include "eligibility_log_handle.h"
#include "EligibilityAnswer.h"

#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>

#define OS_ELIGIBILITY_ROOT "/"

extern xpc_object_t xpc_create_from_plist(void *data, size_t size);

const char * copy_eligibility_domain_answer_plist_path(void) {
    char *absolute_path;
    const char *relative_path = "/private/var/db/os_eligibility/eligibility.plist";
    int size = asprintf(&absolute_path, "%s%s", OS_ELIGIBILITY_ROOT, relative_path);
    if (size == -1) {
        os_log_error(eligibility_log_handle(), "%s: Failed to construct absolute path for relative path: %s", __func__, relative_path);
    }
    return absolute_path;
}

const char * copy_eligibility_domain_public_answer_plist_path(void) {
    char *absolute_path;
    const char *relative_path = "/private/var/db/eligibilityd/eligibility.plist";
    int size = asprintf(&absolute_path, "%s%s", OS_ELIGIBILITY_ROOT, relative_path);
    if (size == -1) {
        os_log_error(eligibility_log_handle(), "%s: Failed to construct absolute path for relative path: %s", __func__, relative_path);
    }
    return absolute_path;
}

int load_eligibility_plist(const char *path, xpc_object_t *result_ptr) {
    struct stat file_stat = {0};
    xpc_object_t result;
    int error_num;
    int fd = open(path, O_NOFOLLOW_ANY);
    if (fd < 0) {
        error_num = errno;
        os_log_error(eligibility_log_handle(), "%s: Failed to open %s: %s(%d)", __func__, path, strerror(error_num), error_num);
        return error_num;
    } else {
        if(fstat(fd, &file_stat) != 0) {
            error_num = errno;
            os_log_error(eligibility_log_handle(), "%s: Failed to stat %s: %s(%d)", __func__, path, strerror(error_num), error_num);
            result = NULL;
        } else {
            size_t file_size = file_stat.st_size;
            if (file_size > INT_MAX) {
                os_log_error(eligibility_log_handle(), "%s: eligibility plist is too large (%zu)", __func__, file_size);
                result = NULL;
                error_num = EFBIG;
            } else {
                void *mapped_data = mmap(NULL, file_size, PROT_READ, MAP_NOCACHE | MAP_PRIVATE, fd, 0);
                if (mapped_data == MAP_FAILED) {
                    error_num = errno;
                    os_log_error(eligibility_log_handle(), "%s: Failed to map file at %s; error: %s", __func__, path, strerror(error_num));
                    result = NULL;
                } else {
                    result = xpc_create_from_plist(mapped_data, file_size);
                    if (result == NULL) {
                        os_log_error(eligibility_log_handle(), "%s: Failed to parse property list", __func__);
                        error_num = -1;
                    } else {
                        xpc_type_t result_type = xpc_get_type(result);
                        if (result_type != XPC_TYPE_DICTIONARY) {
                            os_log_error(eligibility_log_handle(), "%s: Expected plist to be a dictionary but instead was a %s", __func__, xpc_type_get_name(result_type));
                            error_num = -1;
                        } else {
                            error_num = 0;
                        }
                    }
                    munmap(mapped_data, file_size);
                }
            }
        }
        close(fd);
        if (result_ptr && error_num == 0 && result != NULL) {
            *result_ptr = result;
        } else {
            if (result) {
                xpc_release(result);
            }
        }
        return error_num;
    }
}

int _append_plist_keys_to_dictionary(const char *path, xpc_object_t dictionary) {
    xpc_object_t result;
    __block int error_num = load_eligibility_plist(path, &result);
    if (error_num != 0) {
        os_log_error(eligibility_log_handle(), "%s: Failed to read in plist %s: error=%d", __func__, path, error_num);
    } else {
        xpc_dictionary_apply(result, ^bool(const char *key, xpc_object_t value) {
            EligibilityAnswer answer = xpc_dictionary_get_int64(value, "os_eligibility_answer_t");
            if ((int64_t)answer < 0) {
                os_log_error(eligibility_log_handle(), "%s: Unable to read eligibility answer for domain: %s", __func__, key);
                error_num = EDOM;
                return false;
            } else {
                xpc_dictionary_set_uint64(dictionary, key, answer);
                return true;
            }
        });
    }
    if (result != NULL) {
        xpc_release(result);
    }
    return error_num;
}
