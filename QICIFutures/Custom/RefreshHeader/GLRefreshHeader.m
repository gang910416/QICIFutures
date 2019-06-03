//
//  GLRefreshHeader.m
//  kkcoin
//
//  Created by kk_ghostlord on 2018/4/17.
//  Copyright © 2018年 董. All rights reserved.
//

#import "GLRefreshHeader.h"

@interface GLRefreshHeader ()
//    <LanguageToolDelegate>

/**
 箭头视图
 */
@property (readwrite, weak, nonatomic) UIImageView *arrowView;

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation GLRefreshHeader
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PullRefreshArrow"]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}


#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

/* 是否适配异形屏 */
- (void)setFixHeteroScreen:(BOOL)fixHeteroScreen {
    if(_fixHeteroScreen != fixHeteroScreen) {
        
        _fixHeteroScreen = fixHeteroScreen;
        
        if (_fixHeteroScreen) {
            self.mj_h += NavMustAdd;
        }else {
            self.mj_h -= NavMustAdd;
        }
    }
}

/* 是否无导航栏 */
- (void)setIsNonNavBar:(BOOL)isNonNavBar {
    if(_isNonNavBar != isNonNavBar) {
        
        _isNonNavBar = isNonNavBar;
        
        if (_isNonNavBar) {
            self.mj_h += 15.0f;
        }else {
            self.mj_h -= 15.0f;
        }
    }
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    // loading图的样式
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    // 指示图距离状态文字的距离
    self.labelLeftInset = 10.0f;
    
//    [[LanguageTool shareInstace] addDelegate:self];
    // 设置语言
//    [self p_setUpLanguage];

}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.mj_textWith;
        CGFloat textWidth = stateWidth;
        arrowCenterX -= textWidth / 2 + self.labelLeftInset;
    }

    CGFloat arrowCenterY = self.mj_h * 0.25;

    // 异形屏特殊处理
    if (self.fixHeteroScreen) {
        arrowCenterY = (self.mj_h * 0.25) + (NavMustAdd * 0.75);
        self.stateLabel.center = CGPointMake(kDeviceWidth / 2.0f, arrowCenterY);
    }
    
    if(self.isNonNavBar) {
        if (!IS_HETERO_SCREEN) {
            // 不是异形屏并且无导航栏
            arrowCenterY += 15;
            self.stateLabel.center = CGPointMake(kDeviceWidth / 2.0f, arrowCenterY);
        }
    }
    
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);

    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}

    /*
// 设置语言
- (void)p_setUpLanguage {
    
    [self setTitle:KKLocalizedString(MJRefreshHeaderIdleText, @"下拉加载") forState:MJRefreshStateIdle];
    [self setTitle:KKLocalizedString(MJRefreshHeaderPullingText, @"松开立即刷新") forState:MJRefreshStatePulling];
    [self setTitle:KKLocalizedString(MJRefreshHeaderRefreshingText, @"正在刷新") forState:MJRefreshStateRefreshing];

    weakSelf(self);
    self.lastUpdatedTimeText = ^NSString *(NSDate *lastUpdatedTime) {
        strongSelf(weakSelf);
        NSString *resultString = strongSelf.lastUpdatedTimeLabel.text;
        if (lastUpdatedTime) {
            // 1.获得年月日
            NSCalendar *calendar = [strongSelf currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
            NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
            NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
            
            // 2.格式化日期
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            BOOL isToday = NO;
            if ([cmp1 day] == [cmp2 day]) { // 今天
                formatter.dateFormat = @" HH:mm";
                isToday = YES;
            } else if ([cmp1 year] == [cmp2 year]) { // 今年
                formatter.dateFormat = @"MM-dd HH:mm";
            } else {
                formatter.dateFormat = @"yyyy-MM-dd HH:mm";
            }
            NSString *time = [formatter stringFromDate:lastUpdatedTime];
            
            // 3.显示日期
            resultString = [NSString stringWithFormat:@"%@%@%@",
                                              KKLocalizedString(MJRefreshHeaderLastTimeText, @"最后更新"),
                                              isToday ? KKLocalizedString(MJRefreshHeaderDateTodayText, @"今天") : @"",
                                              time];
        } else {
            resultString = [NSString stringWithFormat:@"%@%@",
                                              KKLocalizedString(MJRefreshHeaderLastTimeText, @"最后更新"),
                                              KKLocalizedString(MJRefreshHeaderNoneLastDateText, @"无记录")];
        }

        return resultString;
    };
}

#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark - 语言切换的代理 -

- (void)delegate_languageTool_languageDidChanged:(KKLanguageType)currentLanguageType {
    [self p_setUpLanguage];
}
*/
@end
