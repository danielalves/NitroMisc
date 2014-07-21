//
//  NSBundle+Utils_Nitro.m
//  NitroMisc
//
//  Created by Daniel L. Alves on 18/09/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#import "NSBundle+Utils_Nitro.h"

// NitroMisc
#import "NTRLogging.h"

#pragma mark - Implementation

@implementation NSBundle( Utils_Nitro )

+( NSString * )applicationName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: ( NSString * ) kCFBundleNameKey];
}

+( NSString * )applicationVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: ( NSString * ) kCFBundleVersionKey];
}

-( NSDictionary * )readPropertyListWithName:( NSString * )name error:( out NSError ** )error
{
    if( name.length == 0 )
        return nil;
    
    if( [name hasSuffix: @".plist"] )
        name = [name substringWithRange: NSMakeRange( 0, name.length - @".plist".length )];
        
	NSString *plistPath = [self pathForResource: name
                                         ofType: @"plist"];
    if( !plistPath )
        return nil;
    
    NSData *plistData = [NSData dataWithContentsOfFile: plistPath];
    
    if( !plistData )
        return nil;

    NSDictionary *plist = ( NSDictionary * )[NSPropertyListSerialization propertyListWithData: plistData
                                                                                      options: NSPropertyListImmutable
                                                                                       format: NULL
                                                                                        error: error];
    
    return ( *error ) ? nil : plist;
}

-( NSString * )stringWithEncoding:( NSStringEncoding )encoding fromResourceWithName:( NSString * )name type:( NSString * )type
{
    NSError *error = nil;
    
    NSString *path = [self pathForResource: name ofType: type];
    if( !path )
        return nil;
    
    NSString *str = [NSString stringWithContentsOfFile: path encoding: encoding error: &error];
    
    if( error )
    {
        NTR_LOGE( @"%@", [error localizedDescription] );
        return nil;
    }
    
    return str;
}

@end
