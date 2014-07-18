//
//  NSInvocation+Utils_Nitro.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 15/02/12.
//  Copyright (c) 2012 Daniel L. Alves. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// See NSInvocation documentation:
// "... Use indices 2 and greater for the arguments normally passed in a message..."
//
FOUNDATION_EXPORT const NSInteger kNitroNSInvovationFirstArgumentIndex;

/**
 *  Utility methods for NSInvocation Foundation class
 */
@interface NSInvocation( Utils_Nitro )

/**
 *  Creates a NSInvocation object which fill fire selector on target when invoked.
 *
 *  @param selector The selector which will be fired by the invocation.
 *  @param target   The object to assign to the invocation as target. The target is the receiver 
 *                  of the message sent by invoke, that is, the selector parameter.
 *
 *  @return A NSInvocation object which fill fire selector on target when invoked.
 */
+( NSInvocation * )invocationForSelector:( SEL )selector withTarget:( NSObject * )target;

@end
