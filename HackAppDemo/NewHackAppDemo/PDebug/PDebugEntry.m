//
//  PDebugEntry.m
//  Portal
//
//  Created by Jim on 2016/10/22.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "PDebugEntry.h"
#import <objc/runtime.h>

@implementation PDebugEntry

+(void)load
{
    Class clazz = NSClassFromString(@"ViewController");
    
//    //获取替换前的类方法
    Method testFunction = class_getInstanceMethod(clazz, @selector(testFunction));
//    //获取替换后的类方法
    Method newTestFunction = class_getInstanceMethod(self, @selector(newTestFunction));
    //然后交换类方法
    method_exchangeImplementations(testFunction, newTestFunction);
}

- (void)newTestFunction {
    NSLog(@"I am handsome kuailejim!");
}
@end
