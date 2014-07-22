//
//  SynthesizeSingleton.h
//  Copyright (c) 2009 Matt Gallagher. All rights reserved.
//
//  Modified by Oliver Jones and Daniel L. Alves.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
//  See:
//    - http://www.cocoawithlove.com/2008/11/singletons-appdelegates-and-top-level.html
//

#ifndef NITRO_SYNTHESIZE_SINGLETON_H
#define NITRO_SYNTHESIZE_SINGLETON_H

#import <UIKit/UIKit.h>

/*******************************************
 *
 * To use in header files
 *
 *******************************************/

/**
 *  Generates methods declarations needed to transform a common class into a singleton class.
 *
 *  @param className    The class for which singleton methods declarations will be created.
 *  @param accessorname The accessor name used to obtain the singleton instance.
 *
 *  @see DEFAULT_DECLARE_SINGLETON_FOR_CLASS
 *  @see SYNTHESIZE_SINGLETON_FOR_CLASS
 *  @see DEFAULT_SYNTHESIZE_SINGLETON_FOR_CLASS
 */
#define DECLARE_SINGLETON_FOR_CLASS( className, accessorname ) +( className * )accessorname;

/**
 *  Generates methods declarations needed to transform a common class into a singleton class.
 *  To obtain the singleton instance, call 'sharedInstance'.
 *
 *  Using this macro is the same as using DECLARE_SINGLETON_FOR_CLASS passing
 *  'sharedInstance' as the singleton accessor name.
 *
 *  @param classname The class for which singleton methods declarations will be created.
 *
 *  @see DECLARE_SINGLETON_FOR_CLASS
 *  @see SYNTHESIZE_SINGLETON_FOR_CLASS
 *  @see DEFAULT_SYNTHESIZE_SINGLETON_FOR_CLASS
 */
#define DEFAULT_DECLARE_SINGLETON_FOR_CLASS( className ) DECLARE_SINGLETON_FOR_CLASS( className, sharedInstance )

/*******************************************
 *
 * To use in implementation files
 *
 *******************************************/

/**
 *  Generates methods needed to transform a common class into a singleton class.
 *
 *  @param classname    The class for which singleton methods will be created.
 *  @param accessorname The accessor name used to obtain the singleton instance.
 *
 *  @see DECLARE_SINGLETON_FOR_CLASS
 *  @see DEFAULT_DECLARE_SINGLETON_FOR_CLASS
 *  @see DEFAULT_SYNTHESIZE_SINGLETON_FOR_CLASS
 */
#define SYNTHESIZE_SINGLETON_FOR_CLASS( classname, accessorname )                                   \
                                                                                                    \
static classname *shared##classname = nil;                                                          \
                                                                                                    \
+( void )cleanupFromTerminate                                                                       \
{                                                                                                   \
    shared##classname = nil;                                                                        \
}                                                                                                   \
                                                                                                    \
+( void )registerForCleanup                                                                         \
{                                                                                                   \
    [[NSNotificationCenter defaultCenter] addObserver: self                                         \
                                          selector: @selector( cleanupFromTerminate )               \
                                          name: UIApplicationWillTerminateNotification              \
                                          object: nil];                                             \
}                                                                                                   \
                                                                                                    \
-( void )dealloc                                                                                    \
{                                                                                                   \
    [[NSNotificationCenter defaultCenter] removeObserver: self                                      \
                                                    name: UIApplicationWillTerminateNotification    \
                                                  object: nil];                                     \
}                                                                                                   \
                                                                                                    \
+( classname * )accessorname                                                                        \
{                                                                                                   \
    __block classname *temp;                                                                        \
    temp = shared##classname;                                                                       \
    if( !temp )                                                                                     \
    {                                                                                               \
        static dispatch_once_t p;                                                                   \
        dispatch_once( &p, ^{                                                                       \
            shared##classname = [[self alloc] init];                                                \
            temp = shared##classname;                                                               \
        });                                                                                         \
    }                                                                                               \
    return temp;                                                                                    \
}                                                                                                   \
                                                                                                    \
+( id )allocWithZone:( NSZone * )zone                                                               \
{                                                                                                   \
    static dispatch_once_t p;                                                                       \
                                                                                                    \
    dispatch_once( &p, ^{                                                                           \
        if( shared##classname == nil )                                                              \
        {                                                                                           \
            shared##classname = [super allocWithZone: zone];                                        \
            [self registerForCleanup];                                                              \
        }                                                                                           \
    });                                                                                             \
    return shared##classname;                                                                       \
}                                                                                                   \
                                                                                                    \
-( id )copyWithZone:( NSZone * )zone                                                                \
{                                                                                                   \
    return self;                                                                                    \
}

/**
 *  Generates methods needed to transform a common class into a singleton class.
 *  To obtain the singleton instance, call 'sharedInstance'.
 *
 *  Using this macro is the same as using SYNTHESIZE_SINGLETON_FOR_CLASS passing
 *  'sharedInstance' as the singleton accessor name.
 *
 *  @param classname The class for which singleton methods will be created.
 *
 *  @see DECLARE_SINGLETON_FOR_CLASS
 *  @see DEFAULT_DECLARE_SINGLETON_FOR_CLASS
 *  @see SYNTHESIZE_SINGLETON_FOR_CLASS
 */
#define DEFAULT_SYNTHESIZE_SINGLETON_FOR_CLASS( classname ) SYNTHESIZE_SINGLETON_FOR_CLASS( classname, sharedInstance )

#endif
