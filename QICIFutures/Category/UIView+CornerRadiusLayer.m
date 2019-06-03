//
//  UIView+CornerRadiusLayer.m
//  CYMailDemo
//
//  Created by 李志强 on 2017/11/7.
//  Copyright © 2017年 Qtec. All rights reserved.
//

#import "UIView+CornerRadiusLayer.h"

@implementation UIView (CornerRadiusLayer)

- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (void)setLayerBorderColor:(UIColor *)layerBorderColor {
    self.layer.borderColor = layerBorderColor.CGColor;
    [self _config];
}

- (UIColor *)layerBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setLayerBorderWidth:(CGFloat)layerBorderWidth {
    self.layer.borderWidth = layerBorderWidth;
    [self _config];
}

- (CGFloat)layerBorderWidth {
    return self.layer.borderWidth;
}

- (void)setLayerCornerRadius:(CGFloat)layerCornerRadius {
    self.layer.cornerRadius = layerCornerRadius;
    [self _config];
}

- (CGFloat)layerCornerRadius {
    return self.layer.cornerRadius;
}

- (void)_config {
    self.layer.masksToBounds = YES;
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

- (void)set_SHCornerRadius:(CGFloat)radius {
    [self set_SHCornerRadius:radius BorderColor:nil BorderWidth:0];
}

- (void)set_SHCornerRadius:(CGFloat)radius BorderColor:(UIColor *)borderColor BorderWidth:(CGFloat)borderWidth {
    [self set_SHRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight radius:radius borderColor:borderColor borderWidth:borderWidth];
}

- (void)set_SHRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    [self set_SHRoundingCorners:corners radius:radius borderColor:nil borderWidth:0];
}

- (void)set_SHRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CGSize viewSize = self.frame.size;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    if (borderWidth) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = borderColor.CGColor;
        shapeLayer.lineWidth = borderWidth;
        shapeLayer.path = path.CGPath;
        [self.layer insertSublayer:shapeLayer atIndex:0];
    }
    maskLayer.path = path.CGPath;
    [self.layer setMask:maskLayer];
}

@end
