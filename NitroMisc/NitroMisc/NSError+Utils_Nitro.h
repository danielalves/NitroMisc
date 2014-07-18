//
//  NSError+Utils_Nitro.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 18/04/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Utility methods for NSError Foundation class
 */
@interface NSError( Utils_Nitro )

/**
 *  Creates a NSError object with the specified domain, code and localized description.
 *
 *  @param domain               A string containing the error domain.
 *  @param code                 The error code. Note that error codes are domain specific.
 *  @param localizedDescription A localized string representation of the error that, if present, will be returned by the
 *                              localizedDescription method. This value will be set in the NSError object userInfo dictionary
 *                              with the NSLocalizedDescriptionKey.
 *
 *  @return A NSError object with the specified domain, code and localized description.
 */
+( NSError * )errorWithDomain:( NSString * )domain
                         code:( NSInteger )code
         localizedDescription:( NSString * )localizedDescription;

@end
