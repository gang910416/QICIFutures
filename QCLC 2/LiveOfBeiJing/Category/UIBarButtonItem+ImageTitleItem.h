//
//  UIBarButtonItem+ImageTitleItem.h
//  MHCB2BApp
//
//  Created by 徐天宇 on 16/7/26.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem(ImageTitleItem)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                             color:(UIColor *)color
                          fontSize:(CGFloat)fontSize
                           imgName:(NSString *)imgName
                            target:(id)target
                          selector:(SEL)selector;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                          selector:(SEL)selector;

+ (UIBarButtonItem *)itemWithImgName:(NSString *)imgName
                              target:(id)target
                            selector:(SEL)selector;

+ (UIBarButtonItem *)backItemWithTarget:(id)target selector:(SEL)selector;

@end
