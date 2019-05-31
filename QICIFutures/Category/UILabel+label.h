//
//  UILabel+label.h
//  CouponApp
//
//  Created by liuyongfei on 2018/10/22.
//  Copyright © 2018年 QiCaiShiKong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (label)
/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;
/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;
@end

NS_ASSUME_NONNULL_END
