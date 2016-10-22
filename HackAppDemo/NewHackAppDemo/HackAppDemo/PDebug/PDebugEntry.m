//
//  PDebugEntry.m
//  Portal
//
//  Created by Jim on 2016/10/22.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "PDebugEntry.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import "fishhook.h"

static void * (*orig_dlsym)(void *, const char *);

int my_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data)
{
    return 0;
}

void * my_dlsym(void * __handle, const char * __symbol)
{
    if (strcmp(__symbol, "ptrace") == 0) {
        return &my_ptrace;
    }
    
    return orig_dlsym(__handle, __symbol);
}

@implementation PDebugEntry

+(void)load
{
    orig_dlsym = dlsym(RTLD_DEFAULT, "dlsym");
    rebind_symbols((struct rebinding[1]){{"dlsym", my_dlsym}}, 1);
    
    NSLog(@"PDebug injected.");
    
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
