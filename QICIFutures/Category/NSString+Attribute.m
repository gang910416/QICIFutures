//
//  NSString+Attribute.m
//  kkcoin
//
//  Created by walker on 2018/6/28.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "NSString+Attribute.h"

@implementation NSString (Attribute)

/**
 将当前字符串根据条件生成一个简单的属性字符串
 
 @param font 字体
 @param color 字体颜色
 @return 属性字符串
 */
- (NSAttributedString *)gl_createAttributedStringWithFont:(UIFont * _Nullable)font textColor:(UIColor *_Nullable)color {
    
    NSString *tempStr = isStrEmpty(self) ? @"" : [self copy];
    UIFont *tempFont = font ? : [UIFont systemFontOfSize:17.0f];
    UIColor *tempColor = color ? : [UIColor blackColor];
    
    return [[NSAttributedString alloc] initWithString:tempStr attributes:@{NSFontAttributeName:tempFont,NSForegroundColorAttributeName:tempColor}];
}

- (CGFloat)getHeightWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize {
    
    CGRect textSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont kk_systemFontOfSize:fontSize]} context:nil];
    return textSize.size.height;
}

@end
