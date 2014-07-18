//
//  NitroNSBundleUtilsTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 18/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroMisc
#import "NSBundle+Utils_Nitro.h"

#pragma mark - Interface

@interface NitroNSBundleUtilsTests : XCTestCase
@end

#pragma mark - Implementation

@implementation NitroNSBundleUtilsTests

#pragma mark - applicationName tests

-( void )test_applicationName_returns_application_name
{
}

-( void )test_applicationName_returns_nil_if_application_name_not_specified
{
}

#pragma mark - applicationVersion tests

-( void )test_applicationVersion_returns_application_version
{
}

-( void )test_applicationVersion_returns_nil_if_application_version_not_specified
{
}

#pragma mark - readPropertyListWithName: tests

-( void )test_readPropertyListWithName_reads_property_list_file
{
}

-( void )test_readPropertyListWithName_returns_nil_if_plist_does_not_exist
{
}

-( void )test_readPropertyListWithName_throws_NSInternalInconsistencyException_on_invalid_or_corrupted_files
{
}

#pragma mark - stringWithEncoding:fromResourceWithName:type:

-( void )test_stringWithEncoding_fromResourceWithName_type_reads_files_as_string
{
}

-( void )test_stringWithEncoding_fromResourceWithName_returns_nil_if_file_does_not_exist
{
}

-( void )test_stringWithEncoding_fromResourceWithName_returns_nil_if_file_is_corrupted
{
}

-( void )test_stringWithEncoding_fromResourceWithName_returns_nil_on_encoding_errors
{
}

@end







































