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
}

-( void )test_invocationForSelector_withTarget_sets_invocation_selector
{
}

-( void )test_invocationForSelector_withTarget_sets_invocation_target
{
}

-( void )test_invocationForSelector_withTarget_works_with_nil_selector
{
}

-( void )test_invocationForSelector_withTarget_works_with_nil_target
{
}

@end







































