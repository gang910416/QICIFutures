//
//  NSData+YMExtensions.h
//  youmei
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 um. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (UMExtensions)

/**
 *  base64编码
 *
 *  @param string 字符串
 *
 *  @return 二进制数据
 */
+ (NSData *)um_dataWithBase64EncodedString:(NSString *)string;

/**
 *  固定宽度base64编码
 *
 *  @param wrapWidth 宽度
 *
 *  @return 字符串
 */
- (NSString *)um_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

/**
 *  base64编码
 *
 *  @return 字符串
 */
- (NSString *)um_base64EncodedString;



@end
