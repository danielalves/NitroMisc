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

-( NSDictionary * )readPropertyListWithName:( NSString * )name
{
	NSString *plistPath = [self pathForResource: name
                                         ofType: @"plist"];
    if( !plistPath )
        return nil;
    
    NSData *plistData = [NSData dataWithContentsOfFile: plistPath];
    
    if( !plistData )
        return nil;
    
    NSString *errorDesc = nil;
    NSDictionary *plist = ( NSDictionary * )[NSPropertyListSerialization propertyListFromData: plistData
                                                                             mutabilityOption: NSPropertyListImmutable
                                                                                       format: NULL
                                                                             errorDescription: &errorDesc];

    if( errorDesc )
    {
        NSString *temp = [NSString stringWithString: errorDesc];
		NSString *errMsg = [NSString stringWithFormat: @"Could not load plist file '%@': %@", name, temp];
		
		plist = nil;
		errorDesc = nil;
		
        NTR_LOGE( @"%@", errMsg );

		[NSException raise: NSInternalInconsistencyException format: @"%@", errMsg];
    }
	return plist;
}

-( NSString * )stringWithEncoding:( NSStringEncoding )encoding fromResourceWithName:( NSString * )name type:( NSString * )type
{
    NSError *error = nil;
    
    NSString *path = [self pathForResource: name ofType: type];
    NSString *str = [NSString stringWithContentsOfFile: path encoding: encoding error: &error];
    
    if( error )
    {
        NTR_LOGE( @"%@", [error localizedDescription] );
        return nil;
    }
    
    return str;
}

@end
