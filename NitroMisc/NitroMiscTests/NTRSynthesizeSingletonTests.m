//
//  NTRSynthesizeSingletonTests.m
//  NitroMiscTests
//
//  Created by Daniel L. Alves on 18/07/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// pods
#import <Redefine/ALDRedefinition.h>

// NitroMisc
#import "NTRSynthesizeSingleton.h"

#pragma mark - CustomSingletonClass Helper Type

@interface CustomSingletonClass : NSObject

DECLARE_SINGLETON_FOR_CLASS( CustomSingletonClass, theOne );

@end

@implementation CustomSingletonClass

SYNTHESIZE_SINGLETON_FOR_CLASS( CustomSingletonClass, theOne );

@end

#pragma mark - DefaultSingletonClass Helper Type

@interface DefaultSingletonClass : NSObject
    DEFAULT_DECLARE_SINGLETON_FOR_CLASS( DefaultSingletonClass )
@end

@implementation DefaultSingletonClass

DEFAULT_SYNTHESIZE_SINGLETON_FOR_CLASS( DefaultSingletonClass );

@end

#pragma mark - OnlyDeclaredCustomSingletonClass Helper Type

@interface OnlyDeclaredCustomSingletonClass : NSObject
    DECLARE_SINGLETON_FOR_CLASS( OnlyDeclaredCustomSingletonClass, onlyInstance )
@end

#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation OnlyDeclaredCustomSingletonClass
@end

#pragma clang diagnostic pop

#pragma mark - OnlyDeclaredDefaultSingletonClass Helper Type

@interface OnlyDeclaredDefaultSingletonClass : NSObject
    DEFAULT_DECLARE_SINGLETON_FOR_CLASS( OnlyDeclaredDefaultSingletonClass )
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation OnlyDeclaredDefaultSingletonClass
@end

#pragma clang diagnostic pop

#pragma mark - Interface

@interface NTRSynthesizeSingletonTests : XCTestCase
@end

#pragma mark - Implementation

@implementation NTRSynthesizeSingletonTests

#pragma mark - SYNTHESIZE_SINGLETON_FOR_CLASS tests

-( void )test_synthesize_singleton_for_class_synthesizes_singleton_with_specified_accessor_method
{
    XCTAssertTrue( [CustomSingletonClass respondsToSelector: @selector( theOne )] );
}

#pragma mark - DEFAULT_SYNTHESIZE_SINGLETON_FOR_CLASS tests

-( void )test_default_synthesize_singleton_for_class_synthesizes_singleton_with_sharedInstance_method
{
    XCTAssertTrue( [DefaultSingletonClass respondsToSelector: @selector( sharedInstance )] );
}

#pragma mark - DECLARE_SINGLETON_FOR_CLASS tests

-( void )test_declare_singleton_for_class_declares_singleton_methods_but_do_not_implement_it
{
    XCTAssertThrowsSpecificNamed( [OnlyDeclaredCustomSingletonClass onlyInstance],
                                  NSException,
                                  NSInvalidArgumentException );

    
    @try
    {
        [OnlyDeclaredCustomSingletonClass onlyInstance];
    }
    @catch( NSException *ex )
    {
        XCTAssertTrue( [ex.reason hasPrefix: @"+[OnlyDeclaredCustomSingletonClass onlyInstance]: unrecognized selector sent to class"] );
    }
}

#pragma mark - DEFAULT_DECLARE_SINGLETON_FOR_CLASS tests

-( void )test_default_declare_singleton_for_class_declares_singleton_methods_but_do_not_implement_it
{
    XCTAssertThrowsSpecificNamed( [OnlyDeclaredDefaultSingletonClass sharedInstance],
                                  NSException,
                                  NSInvalidArgumentException );
    
    
    @try
    {
        [OnlyDeclaredDefaultSingletonClass sharedInstance];
    }
    @catch( NSException *ex )
    {
        XCTAssertTrue( [ex.reason hasPrefix: @"+[OnlyDeclaredDefaultSingletonClass sharedInstance]: unrecognized selector sent to class"] );
    }
}

#pragma mark - General Singleton Tests

-( void )test_singleton_does_not_alloc_new_instance
{
    XCTAssertEqual( DefaultSingletonClass.sharedInstance, DefaultSingletonClass.sharedInstance );
    XCTAssertEqual( DefaultSingletonClass.sharedInstance, [[DefaultSingletonClass alloc] init] );
    XCTAssertEqual( DefaultSingletonClass.sharedInstance, [DefaultSingletonClass new] );
    XCTAssertEqual( DefaultSingletonClass.sharedInstance, [DefaultSingletonClass.sharedInstance copy] );
}

-( void )test_singleton_deletes_shared_instance_on_terminate
{
    __block BOOL cleanupCalled = NO;

    [ALDRedefinition redefineClass: [DefaultSingletonClass class]
                          selector: @selector( cleanupFromTerminate )
                withImplementation: ^(id self, ...){
        cleanupCalled = YES;
    }];
    
    // Access the singleton at least once so the instance is created
    [DefaultSingletonClass sharedInstance];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: UIApplicationWillTerminateNotification
                                                        object: nil];
    
    XCTAssertTrue( cleanupCalled );
}

@end
