//
//  NitroNSErrorUtilsTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 18/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroMisc
#import "NSError+Utils_Nitro.h"

#pragma mark - Constants

static NSString * const kNitroNSErrorUtilsTestsErrorDomain = @"error.domain.nitro.NSErrorUtils";

#pragma mark - Interface

@interface NitroNSErrorUtilsTests : XCTestCase
@end

#pragma mark - Implementation

@implementation NitroNSErrorUtilsTests

#pragma mark - errorWithDomain:code:localizedDescription: tests

-( void )test_errorWithDomain_code_localizedDescription_creates_error_object
{
    XCTAssertNotNil( [NSError errorWithDomain: kNitroNSErrorUtilsTestsErrorDomain code: 10 localizedDescription: @"A localized description"] );
}

-( void )test_errorWithDomain_code_localizedDescription_sets_error_domain
{
    NSError *error = [NSError errorWithDomain: kNitroNSErrorUtilsTestsErrorDomain code: 10 localizedDescription: @"A localized description"];
    XCTAssertEqualObjects( error.domain, kNitroNSErrorUtilsTestsErrorDomain );
}

-( void )test_errorWithDomain_code_localizedDescription_sets_error_code
{
    NSError *error = [NSError errorWithDomain: kNitroNSErrorUtilsTestsErrorDomain code: 10 localizedDescription: @"A localized description"];
    XCTAssertEqual( error.code, 10 );
}

-( void )test_errorWithDomain_code_localizedDescription_sets_error_localized_description_on_userInfo_NSLocalizedDescriptionKey
{
    NSError *error = [NSError errorWithDomain: kNitroNSErrorUtilsTestsErrorDomain code: 10 localizedDescription: @"A localized description"];
    XCTAssertEqualObjects( error.userInfo[ NSLocalizedDescriptionKey ], @"A localized description" );
}

-( void )test_errorWithDomain_code_localizedDescription_creates_error_object_even_if_localized_description_is_nil
{
    NSError *error = [NSError errorWithDomain: kNitroNSErrorUtilsTestsErrorDomain code: 10 localizedDescription: nil];
    XCTAssertNotNil( error );
    XCTAssertNil( error.userInfo[ NSLocalizedDescriptionKey ] );
}

-( void )test_invocationForSelector_withTarget_throws
{
    XCTAssertThrowsSpecificNamed( [NSError errorWithDomain: nil code: 10 localizedDescription: @"A localized description"],
                                  NSException,
                                  NSInvalidArgumentException );
}

@end







































