//
//  NSString+Logger_Nitro.m
//  NitroMisc
//
//  Created by Daniel L. Alves on 09/04/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#import "NSString+Logger_Nitro.h"

#pragma mark - Implementation

@implementation NSString( Logger_Nitro )

+( void )nitroLog:( NSString * )format, ...
{
    va_list params;
	va_start( params, format );
    
    @try
    {
        NSLogv( format, params );
    }
    @catch( NSException *ex )
    {
        @throw ex;
    }
    @finally
    {
        va_end( params );
    }
}

@end
