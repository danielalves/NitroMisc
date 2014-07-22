NitroMisc
=========
[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/NitroMisc/badge.png)](http://cocoapods.org/?q=NitroMisc)
[![Platform](http://cocoapod-badges.herokuapp.com/p/NitroMisc/badge.png)](http://cocoadocs.org/docsets/NitroMisc)
[![TravisCI](https://travis-ci.org/danielalves/NitroMisc.svg?branch=master)](https://travis-ci.org/danielalves/NitroMisc)

**NitroMisc** offers a lot of helpful code missing in iOS foundation and uikit classes in addition to utility macros. You will find:
- `NSBundle` utilities
- Shorter `NSError` instantiation
- Shorter `NSInvocation` instantiation
- Logging macros
- Singleton macros
- Helpful macros

Examples
--------

**1) `NSBundle` utilities**

Every app tasks at one place:

```objc
// Returns the value associated with the `kCFBundleNameKey` key in the main bundle information 
// property list
NSString *myAppName = [NSBundle applicationName];

// Returns the value associated with the `kCFBundleVersionKey` key in the main bundle 
// information property list
NSString *myAppVersion = [NSBundle applicationVersion];

// Reads a plist as a `NSDictionary`
NSError *error = nil;
[anyNSBundleObject readPropertyListWithName: @"myPlistNameWithOrWithoutExtension"
                                      error: &error];

// Reads any file as a `NSString`
NSString *fileContent = [anyNSBundleObject stringWithEncoding: NSUTF8StringEncoding
                                         fromResourceWithName: @"yourFileName"
                                                         type: @"yourFileExtension"];
```

**2) Shorter `NSError` instantiation**

Set only the `localizedDescription` key 90% of the time? There you go:

```objc
NSError *muchBetterError = [NSError errorWithDomain: kMyAppNSErrorDomain
                                               code: kMyAppShouldNotHappenErrorCode
                               localizedDescription: @"A localized description"];
```

**3) Shorter `NSInvocation` instantiation**

Boilerplate code to create a `NSInvocation` object? Please:

```objc
NSInvocation *niceInvocation = [NSInvocation invocationForSelector: @selector( invocationSelector )
                                                        withTarget: self];
```

**4) Logging macros**

Macros that log a generic message to the Apple System Log facility using `NSLog`.
When the `DEBUG` preprocessor macro is not defined or is false, calls to these macros will be stripped out of your code, generating no compilation, linking or binary overhead. They also come with the bonus of prepending the log message with the method name from which it was called.

```objc
// These will vanish if the DEBUG preprocessor macro is false
// or is not defined
NTR_LOG( @"%@ Simpson", @"Margie" ); // Logs "Margie Simpson"
NTR_LOGI( @"%@ Simpson", @"Liza" );  // Logs "INFO: Liza Simpson"
NTR_LOGW( @"%@ Simpson", @"Bart" );  // Logs "WARNING: Bart Simpson"
NTR_LOGE( @"%@ Simpson", @"Homer" ); // Logs "ERROR: Homer Simpson"
```

**5) Singleton macros**

Tired of copy and pasting singleton generation macros all over your projects? But no more. **NitroMisc** has all you need and optmized for ARC code.

```objc
// .h file
@interface SingletonClass : NSObject
DEFAULT_DECLARE_SINGLETON_FOR_CLASS( SingletonClass )
@end

// .m file
@implementation SingletonClass
DEFAULT_SYNTHESIZE_SINGLETON_FOR_CLASS( SingletonClass )
@end

// Elsewhere: access the singleton
SingletonClass.sharedInstance
```

Do not like `sharedInstance` accessor name? No problem:

```objc
// .h file
@interface FancySingletonClass : NSObject
DECLARE_SINGLETON_FOR_CLASS( FancySingletonClass, theOne )
@end

// .m file
@implementation FancySingletonClass
SYNTHESIZE_SINGLETON_FOR_CLASS( FancySingletonClass, theOne )
@end

// Elsewhere: access the singleton
FancySingletonClass.theOne
```

**6) Helpful macros**

Use the `SuppressPerformSelectorLeakWarning` macro to suppress "performSelector may cause a leak because its selector is unknown" warnings. Remember: This should only be used when you are sure the object responds to the selector.

```objc
-( void )letsFireASelectorWhoseNameWeDontKnow:( SEL )aSelector
{
    // This code generates no warnings. But if you remove the macro...
    if( [object respondsToSelector: aSelector] )
        SuppressPerformSelectorLeakWarning( [object performSelector: aSelector] );
}
```

Requirements
------------

iOS 4.3 or higher, ARC only

Installation
------------

**NitroMisc** is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

```ruby
pod "NitroMisc"
```

**NitroMisc** adds the `-ObjC` linker flag to targets using it. Without it, categories code would be stripped out, resulting in linker errors. For more info about categories inside static libraries, see: [Building Objective-C static libraries with categories](https://developer.apple.com/library/mac/qa/qa1490/_index.html)

Author
------

- [Daniel L. Alves](http://github.com/danielalves) ([@alveslopesdan](https://twitter.com/alveslopesdan))

License
-------

**NitroMisc** is available under the MIT license. See the LICENSE file for more info.
