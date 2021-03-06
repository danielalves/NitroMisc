//
//  NitroNSStringLoggerTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 17/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroMisc
#import "NTRLogging.h"

#pragma mark - Interface

@interface NitroNSStringLoggerTests : XCTestCase
{
    SEL aSelector;
}
@end

#pragma mark - Implementation

@implementation NitroNSStringLoggerTests

#pragma mark - NTR_LOG tests

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
    [self assertDidLogMessage: @"test" afterRunningLogMacroInsideBlock: ^{ NTR_LOG( @"test" ); }];
    [self assertDidLogMessage: @"test 1, 2, 3" afterRunningLogMacroInsideBlock: ^{ NTR_LOG( @"test %d, %d, %d", 1, 2, 3 ); }];
}

-( void )test_NTR_LOG_prepends_caller_method_name_to_log_message
{
    NSString *expected = @"-[NitroNSStringLoggerTests test_NTR_LOG_prepends_caller_method_name_to_log_message]_block_invoke:\n\ttest";
    [self assertDidLogMessage: expected afterRunningLogMacroInsideBlock: ^{ NTR_LOG( @"test" ); }];
}

#pragma mark - NTR_LOGI tests

-( void )test_NTR_LOGI_prepends_INFO_string
{
    [self assertDidLogMessage: @"INFO: test" afterRunningLogMacroInsideBlock: ^{ NTR_LOGI( @"test" ); }];
}

#pragma mark - NTR_LOGW tests

-( void )test_NTR_LOGW_prepends_WARNING_string
{
    [self assertDidLogMessage: @"WARNING: test" afterRunningLogMacroInsideBlock: ^{ NTR_LOGW( @"test" ); }];
}

#pragma mark - NTR_LOGE tests

-( void )test_NTR_LOGE_prepends_ERROR_string
{
    [self assertDidLogMessage: @"ERROR: test" afterRunningLogMacroInsideBlock: ^{ NTR_LOGE( @"test" ); }];
}

#pragma mark - Helpers

-( void )assertDidLogMessage:( NSString * )message afterRunningLogMacroInsideBlock:( void (^)( void ))logMacroBlock
{
#if TESTS_XCTOOL_STDERR_REDIRECT_BUG
    XCTAssertTrue( YES );
#else
    NSString *documentsFolderPath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) lastObject];

#if TESTS_CREATE_DOCS_DIR
    // We need this when we are running tests on a non OSX iOS developer environment, like Travis CI
    if( ![[NSFileManager defaultManager] fileExistsAtPath: documentsFolderPath] )
    {
        NSError *error = nil;
        if( ![[NSFileManager defaultManager] createDirectoryAtURL: [NSURL fileURLWithPath: documentsFolderPath isDirectory: YES]
                                      withIntermediateDirectories: YES
                                                       attributes: nil
                                                            error: &error] )
        {
            XCTFail( @"Could not create dir %@ - %@", documentsFolderPath, [error localizedDescription] );
            return;
        }
    }
#endif

    NSString *filePath = [documentsFolderPath stringByAppendingPathComponent: @"test.txt"];
    
    const char *lowlevelFilePath = [[NSFileManager defaultManager] fileSystemRepresentationWithPath: filePath];
    FILE *test = fopen( lowlevelFilePath, "w+" );
    if( !test )
    {
        XCTFail( @"Could not create helper file at %s - %s", lowlevelFilePath, strerror(errno));
        return;
    }

    int stderrCopy = dup( fileno(stderr) );
    if( stderrCopy < 0 )
    {
        XCTFail( @"'dup' failed: %s", strerror(errno));
        return;
    }

    int ret = dup2( fileno(test),fileno( stderr ));
    if( ret < 0 )
    {
        XCTFail( @"'dup2' failed: %s", strerror(errno));
        return;
    }
    
    logMacroBlock();
    
    fclose( test );

    ret = dup2( stderrCopy, fileno(stderr) );
    if( ret < 0 )
    {
        XCTFail( @"'dup2' rollback failed: %s", strerror(errno));
        return;
    }
    
    close( stderrCopy );
    
    NSError *error = nil;
    NSString *str = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
    if( error )
    {
        XCTFail( @"Could not read helper file at %@ - %@", filePath, [error localizedDescription] );
        return;
    }

    remove( lowlevelFilePath );

    NSString *formattedSuffix = [NSString stringWithFormat: @"%@\n", message];
    XCTAssertTrue( [str hasSuffix: formattedSuffix], @"\n\nString was '%@' (length: %d)\n\n", ( str ? str : @"<nil>"), str.length );
#endif
}

@end
