//
//  NitroNSStringLoggerTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 17/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroMisc
#import "NSString+Logger_Nitro.h"

#pragma mark - Interface

@interface NitroNSStringLoggerTests : XCTestCase
{
    SEL aSelector;
}
@end

#pragma mark - Implementation

@implementation NitroNSStringLoggerTests

-( void )test_NTR_LOG_compiles_with_constant_string_format_and_no_ellipsis_paramaterers
{
    NTR_LOG( @"Hello!" );
    
    // If this method compiles, our test will have passed. That's
    // why we use this XCTAssertTrue( YES )
    XCTAssertTrue( YES );
}

-( void )test_NTR_LOG_compiles_with_constant_string_format_and_ellipsis_paramaterers
{
    NTR_LOG( @"Hello! %@ %@, would you like %d as always?", @"Mr.", @"Homer", 3 );
    
    // If this method compiles, our test will have passed. That's
    // why we use this XCTAssertTrue( YES )
    XCTAssertTrue( YES );
}

-( void )test_NTR_LOG_logs_message
{
    [self assertLoggedMessage: @"test" afterRunningLogMacroInsideBlock: ^{ NTR_LOG( @"test" ); }];
    [self assertLoggedMessage: @"test 1, 2, 3" afterRunningLogMacroInsideBlock: ^{ NTR_LOG( @"test %d, %d, %d", 1, 2, 3 ); }];
}

-( void )test_NTR_LOGI_prepends_INFO_string
{
    [self assertLoggedMessage: @"INFO: test" afterRunningLogMacroInsideBlock: ^{ NTR_LOGI( @"test" ); }];
}

-( void )test_NTR_LOGW_prepends_WARNING_string
{
    [self assertLoggedMessage: @"WARNING: test" afterRunningLogMacroInsideBlock: ^{ NTR_LOGW( @"test" ); }];
}

-( void )test_NTR_LOGE_prepends_ERROR_string
{
    [self assertLoggedMessage: @"ERROR: test" afterRunningLogMacroInsideBlock: ^{ NTR_LOGE( @"test" ); }];
}

#pragma mark - Helpers

-( void )assertLoggedMessage:( NSString * )message afterRunningLogMacroInsideBlock:( void (^)( void ))logMacroBlock
{
    NSString *documentsFolderPath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) lastObject];
    NSString *filePath = [documentsFolderPath stringByAppendingPathComponent: @"test.txt"];
    
    const char *lowlevelFilePath = [[NSFileManager defaultManager] fileSystemRepresentationWithPath: filePath];
    FILE *test = fopen( lowlevelFilePath, "w+" );
    if( !test )
    {
        XCTFail( @"Could not create helper file" );
        return;
    }
    
    int stderrCopy = dup( STDERR_FILENO );
    dup2( fileno(test),fileno( stderr ));
    
    logMacroBlock();
    
    fclose( test );
    dup2( stderrCopy, STDERR_FILENO );
    close( stderrCopy );
    
    NSError *error = nil;
    NSString *str = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
    if( error )
    {
        XCTFail( @"Could not read helper file" );
        return;
    }

    remove( lowlevelFilePath );

    NSString *formattedSuffix = [NSString stringWithFormat: @"%@\n", message];
    XCTAssertTrue( [str hasSuffix: formattedSuffix] );
}

@end







































