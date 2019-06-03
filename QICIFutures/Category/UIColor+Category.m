//
//  UIColor+Category.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)mainColor{
    return [self colorWithHexString:@"#ffffff"];
}
+ (UIColor *)secondMainColor{
    return [self colorWithHexString:@"#EB4B2B"];
}
+(UIColor *)backgroundColor{
    return [self whiteColor];
}
+ (UIColor *)textColorWithType:(NSInteger)type{
    UIColor *color;
    switch (type) {
        case 0:
        {
            color = [UIColor colorWithHexString:@"#333333"];
        }
            break;
        case 1:
        {
            color = [UIColor colorWithHexString:@"#999999"];
        }
            break;
        case 2:
        {
            color = [UIColor colorWithHexString:@"#212121"];
        }
            break;
        case 3:
        {
            color = [UIColor colorWithHexString:@"#424242"];
        }
            break;
        case 5:
        {
            color = [UIColor colorWithHexString:@"#909398"];
        }
            break;
        case 6:
        {
            color = [UIColor colorWithHexString:@"#CCCCCC"];
        }
            break;
        case 7:
        {
            color = [UIColor colorWithHexString:@"#CDCDCD"];
        }
            break;
        case 8:
        {
            color = [UIColor colorWithHexString:@"#2289EF"];
        }
            break;
        default:
            break;
    }
    return color;
}

+ (UIColor *)separationColor{
    return [self colorWithHexString:@"#dcdcdc"];
}

+ (UIColor *)colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color alpha:1.0f];
}

+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]uppercaseString];
    // string shoule be 6 or 8 charactes
    if ([cString length] < 6 ) {
        return [UIColor clearColor];
    }
    // 如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    //separate into r,g,b substring
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    
}
@end
