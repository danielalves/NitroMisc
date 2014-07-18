//
//  NSString+Logger_Nitro.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 09/04/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#ifndef NITRO_NSSTRING_LOGGER_H
#define NITRO_NSSTRING_LOGGER_H

#import <Foundation/Foundation.h>

/**
 *  Logging utilities.
 *
 *  This category offer logging macros that will be stripped out of your code when the DEBUG preprocessor macro
 *  is not defined or is false. This way, log messages will be kept in your development/testing code, but can be
 *  removed from your production code almost automatically: just remove the DEBUG preprocessor macro on your
 *  production target settings (it should not be there, anyway =P ).
 *
 *  This approach is much better than leaving NSLog calls all over your code, since there will be no runtime
 *  overhead. Afterall, the calls will not even exist in your executable. In addition to that, you will reduce
 *  compilation and linking times.
 */
@interface NSString( Logger_Nitro )

/**
 *  Logs an error message to the Apple System Log facility. See NSLog and NSLogv for more info.
 *
 *  YOU SHOULD NOT CALL THIS METHOD DIRECTLY! Instead, use the LOG* macros, since they offer all the
 *  compilation, linking and code generation benefits described on this category documentation.
 *
 *  @param format  A format string. See “Formatting String Objects” (https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Strings/Articles/FormatStrings.html)
 *                 for examples of how to use this method, and “String Format Specifiers” (https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html)
 *                 for a list of format specifiers. This value must not be nil. If it is, a 
 *                 NSInvalidArgumentException will be raised.
 *
 *  @param ...  A comma-separated list of arguments to substitute into format.
 */
+( void )nitroLog:( NSString * )format, ...;

@end

/**
 *  Logs a generic message to the Apple System Log facility. See NSLog and NSLogv for more info.
 *
 *  When the DEBUG preprocessor macro is not defined or is false, calls to this macro will be stripped out
 *  of your code, generating no compilation, linking or binary overhead.
 *
 *  The only downside of this macro is that it cannot be called directly with a non-constant NSString as
 *  the format parameter. That is:
 *
 *  NSString *str = @"anything";
 *  NTR_LOG( str );  // This will NOT compile
 *
 *  But there is a very easy workaround for this:
 *
 *  NSString *str = @"anything";
 *  NTR_LOG( @"%@", str );  // This WILL compile
 *
 *  @param format  A format string. See “Formatting String Objects” (https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Strings/Articles/FormatStrings.html)
 *                 for examples of how to use this method, and “String Format Specifiers” (https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html)
 *                 for a list of format specifiers. This value must not be nil. If it is, a
 *                 NSInvalidArgumentException will be raised.
 *
 *  @param ...  A comma-separated list of arguments to substitute into format.
 *
 *  @see NTR_LOGI
 *  @see NTR_LOGW
 *  @see NTR_LOGE
 */
#if DEBUG
	#define NTR_LOG( format, ... ) NSLog( @"%s:\n\t" format "\n", __PRETTY_FUNCTION__, ##__VA_ARGS__ )
#else
	#define NTR_LOG( format, ... ) do{}while(0)
#endif

/**
 *  This method calls the NTR_LOG macro prepending the string @"INFO: "
 *  See the NTR_LOG macro for more information.
 *
 *  @see NTR_LOG
 *  @see NTR_LOGW
 *  @see NTR_LOGE
 */
#define NTR_LOGI( format, ... ) NTR_LOG( @"INFO: " format, ##__VA_ARGS__ )

/**
 *  This method calls the NTR_LOG macro prepending the string @"WARNING: "
 *  See the NTR_LOG macro for more information.
 *
 *  @see NTR_LOG
 *  @see NTR_LOGI
 *  @see NTR_LOGE
 */
#define NTR_LOGW( format, ... ) NTR_LOG( @"WARNING: " format, ##__VA_ARGS__ )

/**
 *  This method calls the NTR_LOG macro prepending the string @"ERROR: "
 *  See the NTR_LOG macro for more information.
 *
 *  @see NTR_LOG
 *  @see NTR_LOGI
 *  @see NTR_LOGW
 */
#define NTR_LOGE( format, ... ) NTR_LOG( @"ERROR: " format, ##__VA_ARGS__ )

#endif
