//
//  NSString+YMExtensions.m
//  youmei
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 um. All rights reserved.
//

#import "NSString+UMExtensions.h"

@implementation NSString (UMExtensions)

+  (BOOL)um_stringLenghtNotNil:(NSString *)string
{
    if (string.length > 0) {
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL)um_isBlankString:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}
// 判断是否为手机号码

+ (BOOL)um_deptNumInputShouldNumber:(NSString *)str
{
//    if (str.length == 0) {
//        return NO;
//    }
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
/**
 *  判断字符串是否微信号 -> /^[a-zA-Z]([-_a-zA-Z0-9]{5,19})+$/
 *
 *  @param string 字符串
 *
 *  @return BOOL
 */
+  (BOOL)um_isWeChatString:(NSString *)string
{

    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_-]{5,19}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    if ([pred evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}

+ (BOOL)deptNumInputAllNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9.]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}


@end
