//
//  UIView+CornerRadiusLayer.h
//  CYMailDemo
//
//  Created by 李志强 on 2017/11/7.
//  Copyright © 2017年 Qtec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadiusLayer)

- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor;
/**
 *  边角半径
 */
@property (nonatomic, assign) CGFloat layerCornerRadius;
/**
 *  边线宽度
 */
@property (nonatomic, assign) CGFloat layerBorderWidth;
/**
 *  边线颜色
 */
@property (nonatomic, strong) UIColor *layerBorderColor;

/**设置圆角*/
- (void)set_SHCornerRadius:(CGFloat )radius;

/**设置圆角和边框*/
- (void)set_SHCornerRadius:(CGFloat)radius BorderColor:(UIColor *)borderColor BorderWidth:(CGFloat )borderWidth;

/**设置任意圆角*/
- (void)set_SHRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**设置任意圆角和边框*/
- (void)set_SHRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth;

@end
