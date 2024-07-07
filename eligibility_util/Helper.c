//
//  Helper.c
//  eligibility_util
//
//  Created by Kyle on 2024/7/8.
//

/*
This file is part of Darling.

Copyright (C) 2016 Lubos Dolezel

Darling is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Darling is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Darling.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "Helper.h"

CFTypeRef _OpenCFXPCCreateCFObjectFromXPCObject(xpc_object_t xo) {
    xpc_type_t type = xpc_get_type(xo);

    if (type == XPC_TYPE_DICTIONARY) {
        size_t count = xpc_dictionary_get_count(xo);
        CFStringRef* keys = malloc(count * sizeof(CFStringRef));
        CFTypeRef* values = malloc(count * sizeof(CFTypeRef));
        __block size_t idx = 0;

        xpc_dictionary_apply(xo, ^bool(const char* key, xpc_object_t value) {
            keys[idx] = CFStringCreateWithCString(NULL, key, kCFStringEncodingUTF8);
            values[idx] = _OpenCFXPCCreateCFObjectFromXPCObject(value);
            ++idx;
            return true;
        });

        CFDictionaryRef dict = CFDictionaryCreate(NULL, keys, values, count, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);

        for (size_t i = 0; i < count; ++i) {
            CFRelease(keys[i]);
            CFRelease(values[i]);
        }
        free(keys);
        free(values);

        return dict;
    }

    if (type == XPC_TYPE_ARRAY) {
        size_t count = xpc_array_get_count(xo);
        CFTypeRef* entries = malloc(count * sizeof(CFTypeRef));

        xpc_array_apply(xo, ^bool(size_t idx, xpc_object_t entry) {
            entries[idx] = _OpenCFXPCCreateCFObjectFromXPCObject(entry);
            return true;
        });

        CFArrayRef array = CFArrayCreate(NULL, entries, count, &kCFTypeArrayCallBacks);

        for (size_t i = 0; i < count; ++i)
            CFRelease(entries[i]);
        free(entries);

        return array;
    }

    if (type == XPC_TYPE_STRING) {
        return CFStringCreateWithCString(NULL, xpc_string_get_string_ptr(xo), kCFStringEncodingUTF8);
    }

    if (type == XPC_TYPE_BOOL) {
        return CFRetain(xpc_bool_get_value(xo) == true ? kCFBooleanTrue : kCFBooleanFalse);
    }

    if (type == XPC_TYPE_DATA) {
        return CFDataCreate(NULL, xpc_data_get_bytes_ptr(xo), xpc_data_get_length(xo));
    }

    if (type == XPC_TYPE_INT64) {
        int64_t val = xpc_int64_get_value(xo);
        return CFNumberCreate(NULL, kCFNumberSInt64Type, &val);
    }

    if (type == XPC_TYPE_UINT64) {
        uint64_t val = xpc_uint64_get_value(xo);
        // CFNumber doesn't provide an unsigned 64-bit integer type
        // i guess kCFNumberSInt64Type is the next best thing
        return CFNumberCreate(NULL, kCFNumberSInt64Type, &val);
    }

    if (type == XPC_TYPE_NULL) {
        return CFRetain(kCFNull);
    }

    // TODO: double, date, and uuid

    return NULL;
};
