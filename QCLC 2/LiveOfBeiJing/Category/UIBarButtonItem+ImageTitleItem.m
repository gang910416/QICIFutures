//
//  UIBarButtonItem+ImageTitleItem.m
//  MHCB2BApp
//
//  Created by 徐天宇 on 16/7/26.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import "UIBarButtonItem+ImageTitleItem.h"

@implementation UIBarButtonItem(ImageTitleItem)

+ (UIBarButtonItem *)barButtonItemWithTitle:(nullable NSString *)title
                                      color:(UIColor *)color
                                   fontSize:(CGFloat)fontSize
                                   iconName:(nullable NSString *)imageName
                                     target:(id)target
                                   selector:(SEL)selector{
    
    CGFloat width = 0;
    CGFloat titleWidth = 0;
    CGFloat btnHeight = 44;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    button.tintColor = color ? color : [UIColor grayColor];
    
    if (title && title.length>0) {
        
        fontSize = fontSize>0 ? fontSize : 16;
        
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        
        button.titleLabel.font = font;
        [button setTitle:title forState:UIControlStateNormal];
        titleWidth = [title sizeWithAttributes:@{NSFontAttributeName : font}].width;
        width += titleWidth;
    }
    
    if (imageName && imageName.length>0) {
        
        UIImage *image = [UIImage imageNamed:imageName];
        [button setImage:image forState:UIControlStateNormal];

        if (titleWidth>0) {
            
            CGFloat imgHeight = 16;
            CGFloat imgPadding = 0;
            width = imgHeight + width + imgPadding;
            [button setImageEdgeInsets:(UIEdgeInsets){(btnHeight-imgHeight)/2.0f, 0, (btnHeight-imgHeight)/2.0f, width-imgPadding-imgHeight}];
            [button setTitleEdgeInsets:(UIEdgeInsets){0, imgPadding, 0, 0}];

        }else{
            width += image.size.width;
        }
        
    }
    
    button.frame = (CGRect){0, 0, width, btnHeight};
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barItem;
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                             color:(UIColor *)color
                          fontSize:(CGFloat)fontSize
                           imgName:(NSString *)imgName
                            target:(id)target
                          selector:(SEL)selector{
    return [self barButtonItemWithTitle:title color:color fontSize:fontSize iconName:imgName target:target selector:selector];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                          selector:(SEL)selector {
    return [self itemWithTitle:title color:nil fontSize:15 imgName:nil target:target selector:selector];
}

+ (UIBarButtonItem *)itemWithImgName:(NSString *)imgName
                              target:(id)target
                            selector:(SEL)selector {
    return [self itemWithTitle:nil color:nil fontSize:0 imgName:imgName target:target selector:selector];
}

+ (UIBarButtonItem *)backItemWithTarget:(id)target selector:(SEL)selector {
    UIBarButtonItem *backItem = [self itemWithTitle:@"　　" color:nil fontSize:15 imgName:@"bt_navigation_back_nor" target:target selector:selector];
    UIButton *btn = backItem.customView;
    [btn setImageEdgeInsets:(UIEdgeInsets){10, 0, 10, btn.imageEdgeInsets.right}];
    return backItem;
}

@end
