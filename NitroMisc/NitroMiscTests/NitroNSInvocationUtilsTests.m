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

#pragma mark - Defines

#define TNT_TEST_DOUBLE_RETURN_VALUE 105.3
#define TNT_TEST_NSSTRING_RETURN_VALUE @"invocation test"

#pragma mark - Class Variables

static BOOL classSelectorInvoked;

#pragma mark - Interface

@interface NitroNSInvocationUtilsTests : XCTestCase
{
    BOOL instanceSelectorInvoked;
}
@end

#pragma mark - Implementation

@implementation NitroNSInvocationUtilsTests

#pragma mark - Tests Lifecycle

-( void )setUp
{
    instanceSelectorInvoked = NO;
    classSelectorInvoked = NO;
}

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
    XCTAssertNotNil( [NSInvocation invocationForSelector: @selector( invocationSelectorReturningNonPointer ) withTarget: self] );
}

-( void )test_invocationForSelector_withTarget_throws_NSInvalidArgumentException_on_nil_targets
{
    XCTAssertThrowsSpecificNamed( [NSInvocation invocationForSelector: @selector( invocationSelectorReturningNonPointer ) withTarget: nil],
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
    NSInvocation *invocation = [NSInvocation invocationForSelector: @selector( invocationSelectorReturningNonPointer ) withTarget: self];
    XCTAssertEqual( invocation.selector, @selector( invocationSelectorReturningNonPointer ) );
}

-( void )test_invocationForSelector_withTarget_sets_invocation_target
{
    NSInvocation *invocation = [NSInvocation invocationForSelector: @selector( invocationSelectorReturningNonPointer ) withTarget: self];
    XCTAssertEqualObjects( invocation.target, self );
}

-( void )test_invocationForSelector_withTarget_accepts_classes_as_target
{
    NSInvocation *invocation = [NSInvocation invocationForSelector: @selector( classInvocationSelector ) withTarget: [self class]];
    XCTAssertEqualObjects( invocation.target, [self class] );
}

#pragma mark - +invokeSelector:onTarget:withArguments:returnValue: tests

-( void )test_invokeSelector_onTarget_withArguments_returnValue_throws_NSInvalidArgumentException_on_nil_targets
{
    XCTAssertThrowsSpecificNamed( [NSInvocation invokeSelector: @selector( invocationSelectorReturningNonPointer ) onTarget: nil withArguments: nil returnValue: NULL],
                                   NSException,
                                   NSInvalidArgumentException );
}

-( void )test_nvokeSelector_onTarget_withArguments_returnValue__throws_NSInvalidArgumentException_on_nil_selectors
{
    XCTAssertThrowsSpecificNamed( [NSInvocation invokeSelector: nil onTarget: self withArguments: nil returnValue: NULL],
                                  NSException,
                                  NSInvalidArgumentException );
}

-( void )test_invokeSelector_onTarget_withArguments_returnValue_invokes_selector_on_classes
{
    [NSInvocation invokeSelector: @selector( classInvocationSelector ) onTarget: [self class] withArguments: nil returnValue: NULL];
    XCTAssertTrue( classSelectorInvoked );
}

-( void )test_invokeSelector_onTarget_withArguments_returnValue_invokes_selector_on_instances
{
    [NSInvocation invokeSelector: @selector( invocationSelectorReturningNonPointer ) onTarget: self withArguments: nil returnValue: NULL];
    XCTAssertTrue( instanceSelectorInvoked );
}

-( void )test_invokeSelector_onTarget_withArguments_returnValue_returns_non_pointer_return_value
{
    double ret;
    [NSInvocation invokeSelector: @selector( invocationSelectorReturningNonPointer ) onTarget: self withArguments: nil returnValue: &ret];
    XCTAssertEqual( ret, TNT_TEST_DOUBLE_RETURN_VALUE );
}

-( void )test_invokeSelector_onTarget_withArguments_returnValue_returns_pointer_return_value
{
    NSString *ret;
    [NSInvocation invokeSelector: @selector( invocationSelectorReturningPointer ) onTarget: self withArguments: nil returnValue: &ret];
    XCTAssertEqualObjects( ret, TNT_TEST_NSSTRING_RETURN_VALUE );
}

#pragma mark - Helpers

-( double )invocationSelectorReturningNonPointer
{
    instanceSelectorInvoked = YES;
    return TNT_TEST_DOUBLE_RETURN_VALUE;
}

-( NSString * )invocationSelectorReturningPointer
{
    instanceSelectorInvoked = YES;
    return TNT_TEST_NSSTRING_RETURN_VALUE;
}

+( void )classInvocationSelector
{
    classSelectorInvoked = YES;
}

@end
