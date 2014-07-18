//
//  NTRMacrosTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 18/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroMisc
#import "NTRMacros.h"

#pragma mark - Interface

@interface NTRMacrosTests : XCTestCase
{
    SEL aSelector;
}
@end

#pragma mark - Implementation

@implementation NTRMacrosTests

#pragma mark - SuppressPerformSelectorLeakWarning tests

-( void )test_SuppressPerformSelectorLeakWarning_suppresses_warning
{
    // Turns "performSelector may cause a leak because its selector is unknown" warning
    // into an error
#pragma clang diagnostic push
#pragma clang diagnostic error "-Warc-performSelector-leaks"
    
    // If we have no build errors, thats because SuppressPerformSelectorLeakWarning
    // worked and suppressed the warning (which is an error for now)
    NSObject *object;
    if( [object respondsToSelector: aSelector] )
        SuppressPerformSelectorLeakWarning( [object performSelector: aSelector] );
    
#pragma clang diagnostic pop
    
    // If this method compiles, our test will have passed. That's
    // why we use this XCTAssertTrue( YES )
    XCTAssertTrue( YES );
}

@end
