//
//  QWEHideBarViewController.h
// ASDFutureProject
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//返回按钮的事件回调
typedef BOOL(^NavShouldBackBlock)(UIButton *backBtn);

@interface QICIHideBarViewController : UIViewController
// 导航栏显示是 默认 NO
@property (nonatomic, assign) BOOL isHiddenBar;
// 导航栏背景颜色 默认白色
@property (nonatomic, strong) UIColor *navBackGroundColor;
// 导航栏字体文字 默认无
@property (nonatomic, copy) NSString *navTitleSting;
// 导航栏字体颜色 默认 黑色
@property (nonatomic, strong) UIColor *navTitleColor;
// 导航栏字体大小 默认17
@property (nonatomic, strong) UIFont *navTitleFont;
// 导航栏下划线颜色 默认 239 239 239
@property (nonatomic, strong) UIColor *shadowColor;
// 导航栏下划线显是 默认 NO
@property (nonatomic, assign) BOOL isHiddenShadow;
// 导航栏titleView 默认背景颜色为白色的view
@property (nonatomic, strong) UIView *navTitleView;
// 导航栏titleView的显隐藏 默认隐藏YES
@property (nonatomic, assign) BOOL isHiddenTitleView;
// 是否支持滑动返回 默认隐藏YES
@property (nonatomic, assign) BOOL isGesturesBack;
// 导航栏titleView的返回按钮 默认隐藏YES
@property (nonatomic, assign) BOOL isHiddenBackButton;
/** 返回按钮事件 */
@property (copy, nonatomic) NavShouldBackBlock navBackAction;
@end

NS_ASSUME_NONNULL_END
