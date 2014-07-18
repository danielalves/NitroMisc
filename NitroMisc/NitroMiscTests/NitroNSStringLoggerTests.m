//
//  NitroNSStringLoggerTests.m
//  NitroNSStringLoggerTests
//
//  Created by Daniel L. Alves on 17/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroMisc
#import "NSString+Logger_Nitro.h"

#pragma mark - Interface

@interface NitroNSStringLoggerTests : XCTestCase
@end

#pragma mark - Implementation

@implementation NitroNSStringLoggerTests

-( void )NTR_LOG_compiles_with_constant_string_format_and_no_ellipsis_paramaterers
{
    NTR_LOG( @"Hello!" );
    
    // If this method compiles, our test will have passed. That's
    // why we use this XCTAssertTrue( YES )
    XCTAssertTrue( YES );
}

-( void )NTR_LOG_compiles_with_constant_string_format_and_ellipsis_paramaterers
{
    NTR_LOG( @"Hello! %@ %@, would you like %d as always?", @"Mr.", @"Homer", 3 );
    
    // If this method compiles, our test will have passed. That's
    // why we use this XCTAssertTrue( YES )
    XCTAssertTrue( YES );
}

@end
