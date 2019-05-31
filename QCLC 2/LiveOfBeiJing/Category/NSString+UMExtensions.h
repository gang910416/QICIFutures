//
//  NSString+YMExtensions.h
//  youmei
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 um. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UMExtensions)

/**
 *  判断字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return BOOL
 */
+  (BOOL)um_isBlankString:(NSString *)string;


/**
 *  判断字符串是否是电话号
 *
 *  @param str 字符串
 *
 *  @return BOOL
 */
+ (BOOL)um_deptNumInputShouldNumber:(NSString *)str;


/**
 *  判断字符串是否微信号 -> /^[a-zA-Z]([-_a-zA-Z0-9]{5,19})+$/
 *
 *  @param string 字符串
 *
 *  @return BOOL
 */
+  (BOOL)um_isWeChatString:(NSString *)string;
/**
  *  判断字符串长度是否大于
  *
  *  @param string 字符串
  *
  *  @return BOOL
  */
+  (BOOL)um_stringLenghtNotNil:(NSString *)string;

/**
 *  判断字符串是否是全数字
 *
 *  @param str 字符串
 *
 *  @return BOOL
 */
+ (BOOL)deptNumInputAllNumber:(NSString *)str;
@end
