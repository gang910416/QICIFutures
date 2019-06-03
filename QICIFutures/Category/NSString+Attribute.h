//
//  NSString+Attribute.h
//  kkcoin
//
//  Created by walker on 2018/6/28.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (Attribute)

/**
 将当前字符串根据条件生成一个简单的属性字符串

 @param font 字体,默认为17.0
 @param color 字体颜色，默认为黑色
 @return 属性字符串
 */
- (NSAttributedString *)gl_createAttributedStringWithFont:(UIFont * _Nullable)font textColor:(UIColor *_Nullable)color;

/**
 根据宽度与font生成文字高度
 @param width 宽度
 @param fontSize 字体大小
 */
- (CGFloat)getHeightWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize;
@end
NS_ASSUME_NONNULL_END
