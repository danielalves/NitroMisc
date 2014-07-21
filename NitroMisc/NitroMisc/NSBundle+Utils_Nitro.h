//
//  NSBundle+Utils_Nitro.h
//  NitroMisc
//
//  NitroMisc by Daniel L. Alves on 18/09/11.
//  Copyright (c) 2011 Daniel L. Alves. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Utility methods for NSBundle Foundation class
 */
@interface NSBundle( Utils_Nitro )

/**
 *  Returns the value associated with the kCFBundleNameKey key in the main bundle information property list.
 *
 *  @see applicationVersion
 *  @see readPropertyListWithName
 */
+( NSString * )applicationName;

/**
 *  Returns the value associated with the kCFBundleVersionKey key in the main bundle information property list.
 *
 *  @see applicationName
 *  @see readPropertyListWithName
 */
+( NSString * )applicationVersion;

/**
 *  Searches the bundle and reads all key-value pairs contained in a property list into a dictionary.
 *
 *  @param name The name of the plist file without its extension. Ex: for a file named 'Info.plist',
 *              you should pass @"Info"
 *
 *  @param error If the method does not complete successfully, upon return contains an NSError object
 *               that describes the problem.
 *
 *  @return A dictionary containing all key-value pairs of the specified property list, or nil
 *          if the plist is not found or invalid
 *
 *  @see applicationName
 *  @see applicationVersion
 */
-( NSDictionary * )readPropertyListWithName:( NSString * )name error:( out NSError ** )error;

/**
 *  Reads a bundle file entirely and returns its content as a string.
 *
 *  @param encoding The encoding of the file to be read.
 *  @param name     The name of the resource file. If name is an empty string or nil, returns the first file
 *                  encountered of the supplied type.
 *  @param type     If extension is an empty string or nil, the extension is assumed not to exist and the file
 *                  is the first file encountered that exactly matches name.
 *
 *  @return A string created by reading data from the file named by name and type using the specified encoding. 
 *          If the file can’t be opened or there is an encoding error, returns nil.
 */
-( NSString * )stringWithEncoding:( NSStringEncoding )encoding fromResourceWithName:( NSString * )name type:( NSString * )type;

@end
