//
//  NSInvocationUtils_Nitro.h
//  NitroMisc
//
//  Created by Daniel L. Alves on 15/02/12.
//  Copyright (c) 2012 Daniel L. Alves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation( Utils_Nitro )

+( NSInteger )firstArgumentIndex;
+( NSInvocation * )invocationForSelector:( SEL )selector withTarget:( NSObject * )target;

@end
