//
//  NSInvocation+Utils_Nitro.m
//  NitroMisc
//
//  Created by Daniel L. Alves on 15/02/12.
//  Copyright (c) 2012 Daniel L. Alves. All rights reserved.
//

#import "NSInvocation+Utils_Nitro.h"

#pragma mark - Consts

//
// See NSInvocation documentation:
// "... Use indices 2 and greater for the arguments normally passed in a message..."
//
const NSInteger kNitroNSInvovationFirstArgumentIndex = 2;

#pragma mark - Implementation

@implementation NSInvocation( Utils_Nitro )

+( NSInvocation * )invocationForSelector:( SEL )selector withTarget:( NSObject * )target
{
	NSInvocation *temp = [NSInvocation invocationWithMethodSignature: [target methodSignatureForSelector: selector]];
	[temp setSelector: selector];
	[temp setTarget: target];
	return temp;
}

@end
