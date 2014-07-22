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

+( NSError * )errorWithDomain:( NSString * )domain
                         code:( NSInteger )code
         localizedDescription:( NSString * )localizedDescription
{
    NSDictionary *userInfo = nil;
    if( localizedDescription )
        userInfo = @{ NSLocalizedDescriptionKey: localizedDescription };
    
    return [NSError errorWithDomain: domain code: code userInfo: userInfo];
}

@end
