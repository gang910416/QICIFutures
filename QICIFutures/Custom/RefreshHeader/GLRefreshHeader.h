//
//  GLRefreshHeader.h
//  kkcoin
//
//  Created by kk_ghostlord on 2018/4/17.
//  Copyright © 2018年 董. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface GLRefreshHeader : MJRefreshStateHeader
/** 加载指示图片 */
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** loading 视图 的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/* 是否需要适配异形屏(刘海屏)，用在无导航栏时下拉展示 */
@property (assign, nonatomic) BOOL fixHeteroScreen;
/* 是否没有导航栏 */
@property (assign, nonatomic) BOOL isNonNavBar;
@end
