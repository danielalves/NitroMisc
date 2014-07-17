//
//  NSString+Logger.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 09/04/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#ifndef NSSTRING_LOGGER_H
#define NSSTRING_LOGGER_H

#import <Foundation/Foundation.h>

@interface NSString( Logger_Nitro )

+( void )log:( NSString * )format, ...;

@end

#if DEBUG
	#define LOG( format, ... ) [NSString log: @"%s:\n\t" format "\n", __PRETTY_FUNCTION__, ##__VA_ARGS__ ]
#else
	#define LOG( format, ... )
#endif

#define LOGI( format, ... ) LOG( @"INFO: " format, ##__VA_ARGS__ )
#define LOGW( format, ... ) LOG( @"WARNING: " format, ##__VA_ARGS__ )
#define LOGE( format, ... ) LOG( @"ERROR: " format, ##__VA_ARGS__ )

#endif
