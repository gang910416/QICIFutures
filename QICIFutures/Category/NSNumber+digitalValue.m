//
//  NSNumber+digitalValue.m
//  kkcoin
//
//  Created by 幽雅的暴君 on 2018/12/20.
//  Copyright © 2018 KKCOIN. All rights reserved.
//

#import "NSNumber+digitalValue.h"
#import "NSString+NumberFormatter.h"
@implementation NSNumber (digitalValue)

/* 将字符串转换为小数对象 */
- (NSDecimalNumber *)gl_digitalValue {
    
    NSDecimalNumber *decimalNum = nil;
    
    if (self && [self isKindOfClass:[NSNumber class]]) {
        decimalNum = [[self stringValue] gl_digitalValue];
    }
    
    return decimalNum;
}

@end
