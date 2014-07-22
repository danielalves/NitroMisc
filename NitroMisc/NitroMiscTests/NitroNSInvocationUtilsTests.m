//
//  NitroNSInvocationUtilsTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 18/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroMisc
#import "NSInvocation+Utils_Nitro.h"

#pragma mark - Interface

@interface NitroNSInvocationUtilsTests : XCTestCase
@end

#pragma mark - Implementation

@implementation NitroNSInvocationUtilsTests

#pragma mark - invocationForSelector:withTarget: tests

-( void )test_kNitroNSInvovationFirstArgumentIndex_equals_2
{
    //
    // See NSInvocation documentation:
    // "... Use indices 2 and greater for the arguments normally passed in a message..."
    //
    XCTAssertEqual( kNitroNSInvovationFirstArgumentIndex, 2 );
}

-( void )test_invocationForSelector_withTarget_creates_invocation_object
{
    XCTAssertNotNil( [NSInvocation invocationForSelector: @selector( invocationSelector ) withTarget: self] );
}

-( void )test_invocationForSelector_withTarget_throws_NSInvalidArgumentException_on_nil_targets
{
    XCTAssertThrowsSpecificNamed( [NSInvocation invocationForSelector: @selector( invocationSelector ) withTarget: nil],
                                  NSException,
                                  NSInvalidArgumentException );
}

-( void )test_invocationForSelector_withTarget_throws_NSInvalidArgumentException_on_nil_selectors
{
    XCTAssertThrowsSpecificNamed( [NSInvocation invocationForSelector: nil withTarget: self],
                                  NSException,
                                  NSInvalidArgumentException );
}

-( void )test_invocationForSelector_withTarget_sets_invocation_selector
{
    NSInvocation *invocation = [NSInvocation invocationForSelector: @selector( invocationSelector ) withTarget: self];
    XCTAssertEqual( invocation.selector, @selector( invocationSelector ) );
}

-( void )test_invocationForSelector_withTarget_sets_invocation_target
{
    NSInvocation *invocation = [NSInvocation invocationForSelector: @selector( invocationSelector ) withTarget: self];
    XCTAssertEqualObjects( invocation.target, self );
}

#pragma mark - Helpers

-( void )invocationSelector
{
    // Empty. Just for tests.
}

@end







































