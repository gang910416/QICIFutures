//
//  GLRefreshFooter.m
//  kkcoin
//
//  Created by kk_ghostlord on 2018/4/18.
//  Copyright © 2018年 董. All rights reserved.
//

#import "GLRefreshFooter.h"

@interface GLRefreshFooter ()
//    <LanguageToolDelegate>

@end

@implementation GLRefreshFooter

#pragma mark - 重写父类方法 ----
/** 初始化方法 */
- (void)prepare {
    [super prepare];
    
    
//    [[LanguageTool shareInstace] addDelegate:self];
    // 设置语言
//    [self p_setUpLanguage];
}

/** 控件布局 */
- (void)placeSubviews {
    [super placeSubviews];
    
}

/*
// 设置语言
- (void)p_setUpLanguage {

    [self setTitle:KKLocalizedString(MJRefreshAutoFooterIdleText, @"上拉刷新") forState:MJRefreshStateIdle];
    [self setTitle:KKLocalizedString(MJRefreshAutoFooterRefreshingText, @"正在刷新") forState:MJRefreshStatePulling];
    [self setTitle:KKLocalizedString(MJRefreshAutoFooterNoMoreDataText, @"无数据") forState:MJRefreshStateRefreshing];
    
}

#pragma mark - 语言切换代理 --

- (void)delegate_languageTool_languageDidChanged:(KKLanguageType)currentLanguageType {
    
    [self p_setUpLanguage];
}
*/
@end
