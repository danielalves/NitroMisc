//
//  NSError+Utils_Nitro.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 18/04/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError( Utils_Nitro )

+( NSError * )errorWithCode:( NSInteger )code
                    domain:( NSString * )domain
   andLocalizedDescription:( NSString * )description;

+( NSError * )errorWithCode:( NSInteger )code
                    domain:( NSString * )domain
      localizedDescription:( NSString * )description
               andUserInfo:( NSDictionary * )userInfo;

@end
