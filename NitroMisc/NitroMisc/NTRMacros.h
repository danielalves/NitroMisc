//
//  NTRMacros.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 07/04/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#ifndef NITRO_MACROS_H
#define NITRO_MACROS_H

/**
 *  This macro suppresses the "performSelector may cause a leak because its selector is unknown" warnings
 *  fired by performSelector* calls. This should only be used when you are sure the object responds to
 *  the selector. Example:
 *
 *  -( void )letsFireASelectorWhoseNameWeDontKnow:( SEL )aSelector
 *  {
 *      if( [object respondsToSelector: aSelector] )
 *          SuppressPerformSelectorLeakWarning( [object performSelector: aSelector] );
 *  }
 *
 *  @param commands The command which makes the performSelector* call
 *
 *  @see http://stackoverflow.com/a/7933931
 */
#define SuppressPerformSelectorLeakWarning(commands)                    \
do                                                                      \
{                                                                       \
    _Pragma("clang diagnostic push")                                    \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    commands;                                                           \
    _Pragma("clang diagnostic pop")                                     \
} while(0)

#endif
