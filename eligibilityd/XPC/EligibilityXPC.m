//
//  EligibilityXPC.m
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//

#import "EligibilityXPC.h"
#import "EligibilityLog.h"
#import "XPCSPI.h"
#import "GlobalConfiguration.h"
#import "EligibilityUtils.h"
#import "EligibilityEngine.h"

#import <notify.h>
#import <libproc.h>
#import <sys/stat.h>
#import <dirent.h>

void _sendInputsNeededNotification(void);
void _createDirectoryAtPath(const char * path, BOOL isDirectory);
void _setDataProtectionClassDForPath(const char *path);
void _createDirectories(void);
void _connectionHandler(xpc_object_t object, xpc_connection_t connection);
bool _checkEntitlement(audit_token_t *token, const char *name);
bool _checkTestModeEntitlement(audit_token_t *token);
void _tryExitWhenCleanOnWorkloop_block_invoke(void);

static dispatch_source_t source;

// TODO
void main_block_invoke_1(void) {
    _sendInputsNeededNotification();
    const char *vault_path = copy_eligibility_domain_data_vault_directory_path();
    _createDirectoryAtPath(vault_path, YES);
    free((void *)vault_path);
    
    const char *deamon_path = copy_eligibility_domain_daemon_directory_path();
    _createDirectoryAtPath(deamon_path, NO);
    free((void *)deamon_path);
    
    // OEURLForContainerWithError
    // _createDirectories
    // TODO
}

void main_block_invoke_2(xpc_object_t object) {
    const char * name = xpc_dictionary_get_string(object, _xpc_event_key_name);
    os_log(eligibility_log(), "%s: Got darwin notification %s", __func__, name);
    if (strcmp(name, "AppleLanguagePreferencesChangedNotification") == 0 ||
        strcmp(name, "AFLanguageCodeDidChangeDarwinNotification") == 0 ||
        strcmp(name, "com.apple.coregraphics.GUIConsoleSessionChanged") == 0) {
        [EligibilityEngine.sharedInstance recomputeAllDomainAnswers];
    }
}

void main_block_invoke_3(xpc_object_t object, dispatch_queue_t queue) {
    xpc_type_t type = xpc_get_type(object);
    if (type != XPC_TYPE_CONNECTION) {
        return;
    }
    xpc_connection_t connection = (xpc_connection_t)object;
    xpc_connection_set_target_queue(connection, queue);
    xpc_connection_set_event_handler(connection, ^(xpc_object_t  _Nonnull object) {
        _connectionHandler(object, connection);
    });
    xpc_connection_resume(connection);
    if ([GlobalConfiguration.sharedInstance isMemoryConstrainedDevice]) {
        if (!source) {
            source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_event_handler(source, ^{
                _tryExitWhenCleanOnWorkloop_block_invoke();
            });
        }
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3e10);
        dispatch_source_set_timer(source, time, DISPATCH_TIME_FOREVER, 1e9);
        dispatch_activate(source);
    }
}

void _sendInputsNeededNotification(void) {
    uint32_t status = notify_post("com.apple.os-eligibility-domain.input-needed");
    if (status != 0) {
        os_log_error(eligibility_log(), "%s: Could not send inputs needed notification \\\"com.apple.os-eligibility-domain.input-needed\\\": %u", __FUNCTION__, status);
    }
}

void _createDirectoryAtPath(const char * path, BOOL isDirectory) {
    if (mkdir(path, S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH) == 0) { // 0755
        if (isDirectory) {
            os_log_fault(eligibility_log(), "%s: Successfully created directory \\\"%s\\\"; this should already exist", __FUNCTION__, path);
        }
    } else {
        int error_code = errno;
        if (error_code != EEXIST) {
            os_log_fault(eligibility_log(), "%s: mkdir of path \\\"%s\\\" failed; this directory should already exist: %s(%d)", __FUNCTION__, path, strerror(error_code), error_code);
        }
    }
    _setDataProtectionClassDForPath(path);
}

void _setDataProtectionClassDForPath(const char * path) {
    DIR *dir = opendir(path);
    if (dir == NULL) {
        int descriptor = dirfd(dir);
        // See:  https://developer.apple.com/support/downloads/Apple-File-System-Reference.pdf
        if (fcntl(descriptor, F_SETPROTECTIONCLASS, 0x4)) { // PROTECTION_CLASS_D
            os_log_error(eligibility_log(), "%s: Failed to setclass(PROTECTION_CLASS_D) on directory %s: %s", __FUNCTION__, path, strerror(errno));
        }
        closedir(dir);
    } else {
        os_log_error(eligibility_log(), "%s: opendir of %s failed: %s", __FUNCTION__, path, strerror(errno));
    }
}

void _createDirectories(void);


void _connectionHandler(xpc_object_t object, xpc_connection_t connection) {
    audit_token_t auditToken = {};
    xpc_connection_get_audit_token(connection, &auditToken);
    
    pid_t pid = xpc_connection_get_pid(connection);
    char pathBuffer[8];
    int pathLength = proc_pidpath(pid, pathBuffer, sizeof(pathBuffer));
    NSString *processName = nil;
    if (pathLength >= 1) {
        processName = [NSFileManager.defaultManager stringWithFileSystemRepresentation:pathBuffer length:pathLength].lastPathComponent;
    } else {
        processName = @"(unknown)";
    }
    NSString *process = [NSString stringWithFormat:@"%@(%d)", processName, pid];
    char *description = xpc_copy_description(object);
    os_log(eligibility_log(), "%s: Message from %@: %s", __func__, process, description);
    free(description);
    
    if (xpc_get_type(object) == XPC_TYPE_ERROR) {
        const char *error = xpc_dictionary_get_string(object, XPC_ERROR_KEY_DESCRIPTION);
        os_log_error(eligibility_log(), "%s: Received xpc error: %s", __func__, error);
        return;
    }
    xpc_object_t reply = xpc_dictionary_create_reply(object);
    if (!reply) {
        os_log_error(eligibility_log(), "%s: Failed to construct reply message, canceling connection", __func__);
        xpc_connection_cancel(connection);
        return;
    }
    
    uint64_t messageType = eligibility_xpc_get_message_type(object);
    bool success = NO;
    NSError *error = nil;
    switch (messageType) {
        case 1: {
            if (!_checkEntitlement(&auditToken ,"com.apple.private.eligibilityd.setInput") || !_checkTestModeEntitlement(&auditToken)) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send set input message", __func__, process);
            }
            uint64 input = xpc_dictionary_get_uint64(object, "input");
            xpc_object_t value = xpc_dictionary_get_value(object, "value");
            uint64 status = xpc_dictionary_get_uint64(object, "status");
            if ((input > 9) ||
                ((uint64_t)0x216 >> input == 0) ||
                (value == 0 && (status == 0 || status > 7)) ||
                (value != 0 && status != 0) ||
                ((1 << status) & 0xe1) == 0) {
                error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
                break;
            }
            // TODO: EligibilityEngine
            // success = [EligibilityEngine.sharedInstance setInput:input to:value status: status fromProcess:process withError:error];
            break;
        }
        case 2: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.resetDomain")) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send reset domain message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            // TODO
            break;
        }
        case 3: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.resetAllDomains")) {\
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send reset all domains message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            // TODO
            break;
        }
        case 4: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.forceDomain")) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send force domain message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            // TODO
            break;
        }
        case 5: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.forceDomainSet")) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send force domain set message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            // TODO
            break;
        }
        case 6: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.internalState")) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send internal state message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            // TODO
            break;
        }
        case 7: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.stateDump")) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send state dump message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            // TODO: EligibilityEngine
            // CFTypeRef stateDumpDictionary = [EligibilityEngine.sharedInstance stateDumpWithError: &error];
            CFTypeRef stateDumpDictionary = nil;
            if (stateDumpDictionary) {
                xpc_object_t stateDumpDictionaryXPC = _CFXPCCreateXPCObjectFromCFObject(stateDumpDictionary);
                xpc_dictionary_set_value(reply, "stateDumpDictionary", stateDumpDictionaryXPC);
                success = YES;
            }
            break;
        }
        case 8: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.dumpSysdiagnoseDataToDir")) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send sysdiagnose dump message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            const char *dirPath = xpc_dictionary_get_string(object, "dirPath");
            if (!dirPath) {
                os_log_error(eligibility_log(), "%s: File path read from xpc message was nil, aborting.", __func__);
                error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
            }
            NSURL *dirPathURL = [NSURL fileURLWithFileSystemRepresentation:dirPath isDirectory:YES relativeToURL:nil];
            if (!dirPathURL) {
                os_log_error(eligibility_log(), "%s: Failed to convert directory path %s to an NSURL, aborting.", __func__, dirPath);
                error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
            }
            // TODO: EligibilityEngine
            // success = [EligibilityEngine.sharedInstance dumpToDirectory:dirPathURL withError:&error];
            break;
        }
        case 9: {
            if (!_checkEntitlement(&auditToken, "com.apple.private.eligibilityd.setTestMode") || !_checkTestModeEntitlement(&auditToken)) {
                os_log_error(eligibility_log(), "%s: Process %@ not entitled to send set test mode message", __func__, process);
                xpc_connection_cancel(connection);
                return;
            }
            bool testModeEnabled = xpc_dictionary_get_bool(object, "enabled");
            success = [GlobalConfiguration.sharedInstance setTestMode:testModeEnabled withError:&error];
            break;
        }
        default:
            xpc_connection_cancel(connection);
            return;
    }
    if (success) {
        xpc_dictionary_set_int64(reply, "errorNum", 0);
    } else {
        os_log_error(eligibility_log(), "%s: Message %llu failed: %@", __func__, messageType, error);
        NSError *posixError = nil;
        if (error) {
            if ([error.domain isEqualToString:NSPOSIXErrorDomain]) {
                posixError = error;
            } else {
                for (NSError *underlyingError in error.underlyingErrors) {
                    if ([underlyingError.domain isEqualToString:NSPOSIXErrorDomain]) {
                        posixError = underlyingError;
                        break;
                    }
                }
            }
        } else {
            posixError = nil;
        }
        if (posixError) {
            int64_t errorCode = error.code;
            const char *posixErrorDesc = posixError.description.UTF8String;
            if (posixErrorDesc) {
                xpc_dictionary_set_string(reply, "errorDesc", posixErrorDesc);
            } else {
                os_log_error(eligibility_log(), "%s: Received an error, but couldn't obtain its c-string description: %@", __func__, error);
            }
            xpc_dictionary_set_int64(reply, "errorNum", errorCode);
        } else {
            os_log_fault(eligibility_log(), "%s: Unknown underlying POSIX error for - %@", __func__, error);
            xpc_dictionary_set_int64(reply, "errorNum", 0x6B);
        }
    }
    xpc_connection_send_message(connection, reply);
}

bool _checkEntitlement(audit_token_t *token, const char *name) {
    xpc_object_t entitlement = xpc_copy_entitlement_for_token(name, token);
    if (!entitlement) {
        os_log_error(eligibility_log(), "%s: Missing entitlement %s", __func__, name);
        return false;
    }
    xpc_type_t type = xpc_get_type(entitlement);
    if (type != XPC_TYPE_BOOL) {
        os_log_error(eligibility_log(), "%s: Entitlement %s was the wrong type", __func__, name);
        return false;
    }
    return xpc_bool_get_value(entitlement);
}

bool _checkTestModeEntitlement(audit_token_t *token) {
    if (!GlobalConfiguration.sharedInstance.testMode) {
        return YES;
    }
    if (_checkEntitlement(token, "com.apple.private.eligibilityd.setTestMode")) {
        return YES;
    }
    os_log_error(eligibility_log(), "%s: Missing the com.apple.private.eligibilityd.setTestMode entitlement while test mode is enabled", __func__);
    return NO;
}

void _tryExitWhenCleanOnWorkloop_block_invoke(void) {
    intptr_t result = dispatch_source_testcancel(source);
    if (result) {
        return;
    }
    os_log(eligibility_log(), "%s: Running on a memory-constrained device; eager exiting when clean", __func__);
    xpc_transaction_exit_clean();
}
