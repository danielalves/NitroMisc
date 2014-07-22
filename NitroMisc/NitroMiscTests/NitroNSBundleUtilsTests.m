//
//  NitroNSBundleUtilsTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 18/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// ios
#import <CoreFoundation/CFBundle.h>

// c
#import <stdio.h>
#import <stdlib.h>

// pods
#import <Redefine/ALDRedefinition.h>

// NitroMisc
#import "NSBundle+Utils_Nitro.h"

#pragma mark - Interface

@interface NitroNSBundleUtilsTests : XCTestCase
{
    ALDRedefinition *mainBundleRedefinition;
}
@end

#pragma mark - Implementation

@implementation NitroNSBundleUtilsTests

#pragma mark - Test Case Lifecycle

-( void )setUp
{
    mainBundleRedefinition = [ALDRedefinition redefineClass: [NSBundle class]
                                                   selector: @selector( mainBundle )
                                         withImplementation: ^id( id object, ... ) {
                                             return [NSBundle bundleForClass: NitroNSBundleUtilsTests.class];
                                         }];
}

#pragma mark - applicationName tests

-( void )test_applicationName_returns_application_name_from_kCFBundleNameKey
{
    XCTAssertEqualObjects( [NSBundle applicationName], @"NitroMisc" );
}

-( void )test_applicationName_returns_nil_if_application_name_not_specified
{
    [mainBundleRedefinition stopUsingRedefinition];
    
    XCTAssertNil( [NSBundle applicationName] );
}

#pragma mark - applicationVersion tests

-( void )test_applicationVersion_returns_application_version_from_kCFBundleVersionKey
{
    XCTAssertEqualObjects( [NSBundle applicationVersion], @"1" );
}

-( void )test_applicationVersion_returns_nil_if_application_version_not_specified
{
    [mainBundleRedefinition stopUsingRedefinition];
    
    XCTAssertNil( [NSBundle applicationVersion] );
}

#pragma mark - readPropertyListWithName: tests

-( void )test_readPropertyListWithName_reads_property_list_file
{
    NSError *error = nil;
    NSDictionary *plist = [[NSBundle mainBundle] readPropertyListWithName: @"NitroMiscTests-Info" error: &error];
    
    XCTAssertNotNil( plist );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleNameKey ], @"NitroMisc" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleVersionKey ], @"1" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleDevelopmentRegionKey ], @"en" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleIdentifierKey ], @"ald.nitro.misc-tests" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleInfoDictionaryVersionKey ], @"6.0" );
}

-( void )test_readPropertyListWithName_also_works_with_plist_extension
{
    NSError *error = nil;
    NSDictionary *plist = [[NSBundle mainBundle] readPropertyListWithName: @"NitroMiscTests-Info.plist" error: &error];
    
    XCTAssertNotNil( plist );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleNameKey ], @"NitroMisc" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleVersionKey ], @"1" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleDevelopmentRegionKey ], @"en" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleIdentifierKey ], @"ald.nitro.misc-tests" );
    XCTAssertEqualObjects( plist[ ( NSString * )kCFBundleInfoDictionaryVersionKey ], @"6.0" );
}

-( void )test_readPropertyListWithName_returns_nil_if_plist_does_not_exist
{
    [mainBundleRedefinition stopUsingRedefinition];
    
    NSError *error = nil;
    XCTAssertNil( [[NSBundle mainBundle] readPropertyListWithName: @"NitroMiscTests-Info" error: &error] );
}

-( void )test_readPropertyListWithName_returns_error_on_invalid_or_corrupted_files
{
    NSString *corruptedPlistName = nil;
    const char *corruptedFileSystemPath = [NitroNSBundleUtilsTests createCorruptedPlistFromPlistWithName: @"NitroMiscTests-Info"
                                                                                      corruptedPlistName: &corruptedPlistName];
    NSError *error = nil;
    @try
    {
        [ALDRedefinition redefineClassInstances: [NSBundle class]
                                       selector: @selector( pathForResource:ofType: )
                             withImplementation: ^id( id object, ... ) {
                                 return [NSString stringWithUTF8String: corruptedFileSystemPath];
                             }];
        
        NSDictionary *result = [[NSBundle mainBundle] readPropertyListWithName: corruptedPlistName error: &error];
        
        XCTAssertNil( result );
        XCTAssertNotNil( error );
    }
    @catch( NSException *ex )
    {
        @throw ex;
    }
    @finally
    {
        // Deletes the corrupted plist
        remove( corruptedFileSystemPath );
    }
}

#pragma mark - stringWithEncoding:fromResourceWithName:type:

-( void )test_stringWithEncoding_fromResourceWithName_type_reads_files_as_string
{
    NSString *plist = [[NSBundle mainBundle] stringWithEncoding: NSUTF8StringEncoding
                                           fromResourceWithName: @"NitroMiscTests-Info"
                                                           type: @"plist"];

    NSString *expected = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n<dict>\n\t<key>CFBundleName</key>\n\t<string>NitroMisc</string>\n\t<key>CFBundleDevelopmentRegion</key>\n\t<string>en</string>\n\t<key>CFBundleExecutable</key>\n\t<string>${EXECUTABLE_NAME}</string>\n\t<key>CFBundleIdentifier</key>\n\t<string>ald.nitro.misc-tests</string>\n\t<key>CFBundleInfoDictionaryVersion</key>\n\t<string>6.0</string>\n\t<key>CFBundlePackageType</key>\n\t<string>BNDL</string>\n\t<key>CFBundleShortVersionString</key>\n\t<string>1.0</string>\n\t<key>CFBundleSignature</key>\n\t<string>????</string>\n\t<key>CFBundleVersion</key>\n\t<string>1</string>\n</dict>\n</plist>\n";
    
    
    XCTAssertEqualObjects( plist, expected );
}

-( void )test_stringWithEncoding_fromResourceWithName_returns_nil_if_file_does_not_exist
{
    [mainBundleRedefinition stopUsingRedefinition];
    
    XCTAssertNil( [[NSBundle mainBundle] stringWithEncoding: NSUTF8StringEncoding
                                       fromResourceWithName: @"NitroMiscTests-Info"
                                                       type: @"plist"] );
}

-( void )test_stringWithEncoding_fromResourceWithName_returns_nil_on_encoding_errors
{
    XCTAssertNil( [[NSBundle mainBundle] stringWithEncoding: NSUTF32LittleEndianStringEncoding
                                       fromResourceWithName: @"NitroMiscTests-Info"
                                                       type: @"plist"] );
}

#pragma mark - Helpers

+( const char * )createCorruptedPlistFromPlistWithName:( NSString * )originalPlistName corruptedPlistName:( out NSString ** )corruptedPlistName
{
    *corruptedPlistName = [NSString stringWithFormat: @"Corrupted%@", originalPlistName];
    
    // Read the contents of the plist
    NSString *originalFilePath = [[NSBundle mainBundle] pathForResource: originalPlistName ofType: @"plist"];
    const char *originalFileSystemPath = [[NSFileManager defaultManager] fileSystemRepresentationWithPath: originalFilePath];
    FILE *originalPlist = fopen( originalFileSystemPath, "rb" );
    fseek( originalPlist, 0, SEEK_END );
    long originalPlistSizeInBytes = ftell( originalPlist );
    rewind( originalPlist );
    char *originalPlistContent = malloc(originalPlistSizeInBytes + 1);
    fread( originalPlistContent, originalPlistSizeInBytes, 1, originalPlist);
    fclose( originalPlist );
    
    // Create a corrupted plist
    NSString *corruptedFilePath = [originalFilePath stringByReplacingOccurrencesOfString: originalPlistName withString: *corruptedPlistName];
    const char *corruptedFileSystemPath = [[NSFileManager defaultManager] fileSystemRepresentationWithPath: corruptedFilePath];
    FILE *corruptedPlist = fopen( corruptedFileSystemPath, "w+" );
    fwrite( originalPlistContent, sizeof( char ), originalPlistSizeInBytes - 20, corruptedPlist );
    fclose( corruptedPlist );
    free( originalPlistContent );
    
    return corruptedFileSystemPath;
}

@end
