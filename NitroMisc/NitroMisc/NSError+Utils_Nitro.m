//
//  NSError+Utils_Nitro.m
//  NitroMisc
//
//  Created by Daniel L. Alves on 18/04/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#import "NSError+Utils_Nitro.h"

#pragma mark - Implementation

@implementation NSError( Utils_Nitro )

+( NSError * )errorWithCode:( NSInteger )code domain:( NSString * )domain andLocalizedDescription:( NSString * )description
{
    return [NSError errorWithCode: code
                           domain: domain
             localizedDescription: description
                      andUserInfo: nil];
}

+( NSError * )errorWithCode:( NSInteger )code
                    domain:( NSString * )domain
      localizedDescription:( NSString * )description
               andUserInfo:( NSDictionary * )userInfo
{
    NSMutableDictionary *finalUserInfo = [NSMutableDictionary dictionaryWithDictionary: userInfo];
    [finalUserInfo setObject: description forKey: NSLocalizedDescriptionKey];
    
	return [NSError errorWithDomain: domain code: code userInfo: finalUserInfo];
}

@end
