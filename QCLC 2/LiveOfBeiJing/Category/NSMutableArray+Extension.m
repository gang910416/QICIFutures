//
//  NSMutableArray+Extension.m
//  test
//
//  Created by liuyongfei on 2018/10/31.
//  Copyright © 2018 liyongfei. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)
+ (void)load {
    
    Class arrayMClass = NSClassFromString(@"__NSArrayM");
    
    //获取系统的添加元素的方法
    Method addObject = class_getInstanceMethod(arrayMClass, @selector(addObject:));
    
    //获取我们自定义添加元素的方法
    Method avoidCrashAddObject = class_getInstanceMethod(arrayMClass, @selector(avoidCrashAddObject:));
    
    //将两个方法进行交换
    //当你调用addObject,其实就是调用avoidCrashAddObject
    //当你调用avoidCrashAddObject，其实就是调用addObject
    method_exchangeImplementations(addObject, avoidCrashAddObject);
}

- (void)avoidCrashAddObject:(id)anObject {
    
    

    //异常的名称
    NSString *exceptionName = @"**************  自定义数组异常  ********************";
    //异常的原因
    NSString *exceptionReason = @" 数组中添加了空的元素，请检查哦~  ";
    //异常的信息
    NSDictionary *exceptionUserInfo = nil;
    
    NSException *exception1 = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionUserInfo];

    
    @try {
        [self avoidCrashAddObject:anObject];//其实就是调用addObject
    }
    @catch (NSException *exception) {
        
        
        //能来到这里,说明可变数组添加元素的代码有问题
        //你可以在这里进行相应的操作处理
        
        NSLog(@"异常名称:%@   异常原因:%@",exception1.name, exception1.reason);
    }
    @finally {
        //在这里的代码一定会执行，你也可以进行相应的操作
    }
}

@end
