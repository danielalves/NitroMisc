//
//  NTRMacros.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 07/04/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#ifndef NITRO_MACROS_H
#define NITRO_MACROS_H

//
// See:
// http://stackoverflow.com/a/7933931
//
#define SuppressPerformSelectorLeakWarning(commands) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
commands; \
_Pragma("clang diagnostic pop") \
} while(0)

#endif
