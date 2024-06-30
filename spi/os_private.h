//
//  os_private.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/23.
//

#import <Foundation/Foundation.h>

OS_EXPORT OS_WARN_RESULT
bool os_variant_has_internal_content(const char *subsystem);

OS_EXPORT __cold __dead2
void _os_crash(const char *);
