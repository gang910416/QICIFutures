//
//  TabControlView.m
//  kkcoin
//
//  Created by kk_ghostlord on 2018/4/18.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "TabControlView.h"

// item 默认的tag
#define kBaseItemTag (5679)

@interface TabControlView ()
/**
 当前正在展示的titles
 */
@property (readwrite, strong, nonatomic) NSArray *titles;

/**
 选项的集合
 */
@property (strong, nonatomic) NSMutableArray *items;

/**
 可滑动内容视图
 */
@property (strong, nonatomic) UIScrollView *contentView;

/**
 选项的实际宽度
 */
@property (assign, nonatomic) CGFloat itemWidth;

/**
 指示光标
 */
@property (strong, nonatomic) UIView *cursorView;

/**
 当前选中的下标
 */
@property (readwrite, assign, nonatomic) NSInteger currentIndex;

@end

@implementation TabControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        // 设置一些初始化参数
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(nonnull NSArray *)titles{
    
    if (self = [super initWithFrame:frame]) {
        
        if (titles) {
            self.titles = [titles copy];
        }
        self.defaultIndex = 0;
        self.isShowCursor = YES;
        self.itemMinWidth = 50.0f;
        self.cursorColor = [UIColor redColor];
        self.cursorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.cursorHeight = 3.0f;
        self.cursorAnimated = YES;
        self.nomalColor = [UIColor whiteColor];
        self.selectedColor = [UIColor blackColor];
        // 设置基本UI
        [self p_asd_configUI];
        // 设置所有选项
        [self p_setItems];
    }
    return self;
}

#pragma mark - 布局方法  -------

- (void)p_asd_configUI {
    
    [self addSubview:self.contentView];
    if (self.rightView) {
        [self addSubview:self.rightView];
    }
    [self p_layoutWithFrame];
}

- (void)p_layoutWithFrame {
    
    if (self.rightView) {
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width - CGRectGetWidth(self.rightView.frame), self.frame.size.height);
        self.rightView.center = CGPointMake(self.frame.size.width - (self.rightView.frame.size.width / 2.0), self.frame.size.height / 2.0);
        
    }else {
        self.contentView.frame = self.bounds;
    }
}

/**
 设置选项
 */
- (void)p_setItems {

    if (_contentView) {
        [_contentView removeAllSubViewAndDestroy:YES];
    }

    [self.items removeAllObjects];
    if (self.titles && self.titles.count >= 1) {
        // 刷新选项宽度
        [self p_refreshItemWidth];
        // 设置内容宽度
        CGFloat contentWidth = self.titles.count * self.itemWidth;
        self.contentView.contentSize = CGSizeMake(contentWidth > self.contentView.frame.size.width ? contentWidth : self.contentView.frame.size.width, self.contentView.frame.size.height);
        // 标题宽度
        for (int a = 0; a < self.titles.count ; a ++) {
            
            UIButton * tempItem = [self p_getItemAtIndex:a title:self.titles[a] ? self.titles[a] : @""];
            
            // 设置Frame
            if (tempItem) {
                if (CGRectEqualToRect(tempItem.frame, CGRectZero)) {
                    tempItem.frame = CGRectMake(a * self.itemWidth, 0, self.itemWidth, self.contentView.frame.size.height);
                }
            }
            
            // 添加到选项容器中
            [self.items addObject:tempItem];
            // 添加到contentView
            [self.contentView addSubview:tempItem];
        }
        // 设置选中光标
        [self p_setUpCursor];
    }
}

#pragma mark - 控件事件 ----


/**
 选项控件事件

 @param item 选项对象
 */
- (void)p_itemAction:(UIButton *)item {
    // 内部点击的不禁用代理
    [self p_itemAction:item disabledDelegate:NO];
    
}

/**
 选项控件事件
 
 @param item 选项对象
 */
- (void)p_itemAction:(UIButton *)item disabledDelegate:(BOOL)isDisabled {
    
    if (item && [self.items containsObject:item]) {
        if (item.tag) {
            NSInteger index = item.tag - kBaseItemTag;
            self.currentIndex = index;
            // 是否可以响应
            BOOL isCanResponse = YES;
            if (_delegate && [_delegate respondsToSelector:@selector(tabContolView:willSeletedItem:index:)]) {
                isCanResponse = [_delegate tabContolView:self willSeletedItem:item index:index];
            }
            // 可以响应
            if (isCanResponse) {
                if(!isDisabled && _delegate && [_delegate respondsToSelector:@selector(tabControlVeiw:didSelectedItem:index:)]) {
                    [_delegate tabControlVeiw:self didSelectedItem:item index:index];
                }
                [self p_updateItemNomalColor:self.nomalColor selectedColor:self.selectedColor];
                [self p_updateCursorViewCenterAtIndex:index animated:self.cursorAnimated];
            }
        }
    }
}

#pragma mark - 赋值或set方法 ----

- (void)setIsShowCursor:(BOOL)isShowCursor {
    _isShowCursor = isShowCursor;
    [self p_setUpCursor];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    if(cursorColor && [cursorColor isKindOfClass:[UIColor class]]) {
        _cursorColor = cursorColor;
        self.cursorView.backgroundColor = _cursorColor;
    }
}

- (void)setCursorInset:(UIEdgeInsets)cursorInset {
    if (!UIEdgeInsetsEqualToEdgeInsets(_cursorInset, cursorInset)) {
        _cursorInset = cursorInset;
        
        [self p_setItems];
    }
}

- (void)setRightView:(UIView *)rightView {
    if (rightView && !CGRectEqualToRect(CGRectZero, rightView.frame)) {
        _rightView = rightView;
        [self updateLayout];
    }
}

- (void)setNomalColor:(UIColor *)nomalColor {
    if(nomalColor && [nomalColor isKindOfClass:[UIColor class]]) {
        _nomalColor = nomalColor;
        [self p_updateItemNomalColor:_nomalColor selectedColor:self.selectedColor];
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    if (selectedColor && [selectedColor isKindOfClass:[UIColor class]]) {
        _selectedColor = selectedColor;
        
        [self p_updateItemNomalColor:self.nomalColor selectedColor:_selectedColor];
    }
}

- (void)setBtnFont:(UIFont *)btnFont {
    if(btnFont) {
        _btnFont = btnFont;
        // 更新选项字体
        [self p_updateItemFont];
    }
}

#pragma mark - 公共方法 ------

/**
 选中某个下标的选项
 
 @param index 下标
 @param isDisabled 是否禁用当前选择的代理方法
 */
- (void)selectAtIndex:(NSInteger)index disabledDelegate:(BOOL)isDisabled {
    
    if (index < self.titles.count) {
        UIButton *item = self.items[index];
        if (item.enabled) {
            [self p_itemAction:item disabledDelegate:isDisabled];
        }
    }
}

/**
 根据某个标题选中选项
 
 @param title 标题
 */
- (void)selectAtTitle:(NSString *)title {
    if (title && title.length > 0) {
        if ([self.titles containsObject:title]) {
            NSInteger index = [self.titles indexOfObject:title];
            UIButton *item = self.items[index];
            if (item) {
                [self p_itemAction:item disabledDelegate:NO];
            }
        }
    }
}

/**
 更新标题，根据新的标题重新布局
 
 @param titles 新的标题数组
 @param isDisabled 禁用此次代理事件
 */
- (void)updateTitles:(NSArray *)titles disabledDelegate:(BOOL)isDisabled {
    
    if(titles && titles.count) {
        self.titles = [titles copy];
        
        [self updateLayout];
        
        if (self.currentIndex < self.titles.count && !isDisabled) {
            [self selectAtIndex:self.currentIndex disabledDelegate:NO];
        }
    }
}

/**
 更新某个下标的标题
 
 @param title 需要更新为的标题
 @param index 需要更新的选项的下标
 */
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if (index < self.titles.count && title && title.length > 0) {
        // 更新标题数组
        NSMutableArray *tempTitles = [self.titles mutableCopy];
        [tempTitles replaceObjectAtIndex:index withObject:title];
        self.titles = tempTitles.copy;
        // 更新选项的标题
        UIButton *item = [self.items objectAtIndex:index];
        [item setTitle:title forState:UIControlStateNormal];
    }
}

/**
 更新布局
 */
- (void)updateLayout {
    // 移除所有子视图并置为空
    [self removeAllSubViewAndDestroy:YES];
    
    [self p_asd_configUI];
    
    [self p_setItems];
}

///**
// 展示小红点
// 
// @param index 下标
// */
//- (void)showBadgeWithIndex:(NSInteger)index {
//    
//    if (index >= 0 && index < self.items.count) {
//        UIButton *btn = [self.items objectAtIndex:index];
//        if (btn) {
//            [btn.titleLabel showBadge];
//        }
//    }
//}
//
///**
// 清除小红点
// 
// @param index 下标
// */
//- (void)clearBadgeWithIndex:(NSInteger)index {
//    
//    if (index >= 0 && index < self.items.count) {
//        UIButton *btn = [self.items objectAtIndex:index];
//        if (btn) {
//            [btn.titleLabel clearBadge];
//        }
//    }
//}

#pragma mark - 私有方法 ----

/**
 更新选项宽度
 */
- (void)p_refreshItemWidth {
    
    if (self.titles && self.titles.count) {
        
        [self p_asd_configUI];
        
        CGFloat averageWidth = self.contentView.frame.size.width / self.titles.count;
        
        self.itemWidth = averageWidth >= self.itemMinWidth ? averageWidth : self.itemMinWidth;
    }
}

/**
 获得选项按钮
 
 @param index 选项的下标
 @param title 选项的标题
 */
- (UIButton *)p_getItemAtIndex:(NSInteger)index title:(NSString *)title {
    
    if (isStrEmpty(title)) {
        return nil;
    }
    
    UIButton *item = nil;
    if(_delegate && [_delegate respondsToSelector:@selector(tabContolView:willCreateItemAtIndex:title:)]) {
        // 用户自定义的按钮
        item = [_delegate tabContolView:self willCreateItemAtIndex:index title:title];
    }
    
    if (!item && index < self.items.count) {
        item = [self.items objectAtIndex:index];
    }
    
    if (!item) {
        // 默认按钮
        item = [[UIButton alloc] init];
        [item setTitle:title forState:UIControlStateNormal];
        if (self.btnFont) {
            [item.titleLabel setFont:self.btnFont];
        }else {
            item.titleLabel.font = [UIFont kk_systemFontOfSize:14.0f];
        }
    }
    
    [item setTitleColor:self.nomalColor forState:UIControlStateNormal];
    // 设置事件和tag
    [item addTarget:self action:@selector(p_itemAction:) forControlEvents:UIControlEventTouchUpInside];
    item.tag = kBaseItemTag + index;
    return item;
}


/**
 设置光标
 */
- (void)p_setUpCursor {
    
    if (self.isShowCursor && self.items.count >= 1) {
        // 设置光标的大小
        self.cursorView.frame = CGRectMake(0, self.frame.size.height - self.cursorHeight, self.itemWidth - self.cursorInset.left - self.cursorInset.right, self.cursorHeight - self.cursorInset.top - self.cursorInset.bottom);
        // 添加到父视图
        [self.contentView addSubview:self.cursorView];
        
        // 设置光标的中心点
        if (self.currentIndex > 0 && self.currentIndex < self.titles.count) {
            [self p_updateCursorViewCenterAtIndex:self.currentIndex animated:NO]; // 禁止动画防止静默刷新时显示位移动画
        }else if (self.defaultIndex < self.titles.count) {
            [self p_updateCursorViewCenterAtIndex:self.defaultIndex animated:self.cursorAnimated];
        }else {
            [self p_updateCursorViewCenterAtIndex:0 animated:self.cursorAnimated];
        }
        
    }else {
        if (_cursorView) {
            _cursorView.hidden = YES;
            [_cursorView removeFromSuperview];
            _cursorView = nil;
        }
    }
}

/**
 光标中心点设置
 
 @param index 选中的选项下标
 @param animated 是否使用动画
 */
- (void)p_updateCursorViewCenterAtIndex:(NSInteger)index animated:(BOOL)animated {
    
    if(index >= self.titles.count) {
        return;
    }
    // 记录当前选中的下标
    self.currentIndex = index;
    // 获得当前选中的item
    UIButton *item = self.items[index];
    
    CGPoint tempCenter = CGPointMake(item.center.x + ((self.cursorInset.left - self.cursorInset.right) / 2.0), (item.frame.size.height - (self.cursorHeight / 2.0)) - ((self.cursorInset.top - self.cursorInset.bottom) / 2.0));
    
    // 修复内容视图的偏移量，增强用户体验
    __weak typeof(self)weakSelf = self;
    [self p_fixContentViewOffsetWithItem:item index:index completation:^{
        // 光标位移动画
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [UIView animateWithDuration:animated ? 0.2 : 0.0 animations:^{
            
            strongSelf.cursorView.center = tempCenter;
        } completion:^(BOOL finished) {
//            NSLog(@"光标动画结束");
        }];
    }];
}

/**
 修复内容视图的偏移量，增强用户体验
 尽量让用户点击的选项偏移到中央位置
 
 @param item 选项对象
 @param index 选项的下标
 */
- (void)p_fixContentViewOffsetWithItem:(UIButton *)item index:(NSInteger)index completation:(dispatch_block_t)completation {
    
    if(self.contentView.contentSize.width <= self.contentView.frame.size.width) {
        
        if (completation) {
            dispatch_async(dispatch_get_main_queue(), completation);
        }
        
        return;
    }
    
    CGFloat offSetX = item.center.x - (self.contentView.frame.size.width / 2.0);
    
    CGFloat maxOffSetX = self.contentView.contentSize.width - self.contentView.frame.size.width;
    
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    
    if (offSetX < 0) {
        offSetX = 0.0f;
    }
    
    [self.contentView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
    if (completation) {
        dispatch_async(dispatch_get_main_queue(), completation);
    }
}

/**
 更新选项颜色

 @param nomalColor 未被选中的颜色
 @param selectedColor 选中的颜色
 */
- (void)p_updateItemNomalColor:(UIColor *)nomalColor selectedColor:(UIColor *)selectedColor {
    
    if (self.items && self.items.count >= 1) {
        
        for (int a = 0 ; a < self.items.count; a ++) {
            UIButton *btn = self.items[a];
            if (a == self.currentIndex) {
                [btn setTitleColor:selectedColor forState:UIControlStateNormal];
                [btn setSelected:YES];
            }else {
                [btn setSelected:NO];
                [btn setTitleColor:nomalColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)p_updateItemFont {
    
    if (self.btnFont) {
        
        for (UIButton *btn in self.items) {
            [btn.titleLabel setFont:self.btnFont];
        }
    }
}

#pragma mark - 懒加载 ---------

- (NSMutableArray *)items {
    if (!_items) {
        _items = @[].mutableCopy;
    }
    return _items;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}

- (UIView *)cursorView {
    if (!_cursorView) {
        _cursorView = [[UIView alloc] init];
        [_cursorView setBackgroundColor:self.cursorColor];
    }
    return _cursorView;
}

@end

@implementation UIView (RemoveAllSubView)
/**
 清除当前的view上所有的子视图
 
 @param isDestroy 是否将子视图置为空
 */
- (void)removeAllSubViewAndDestroy:(BOOL)isDestroy {
    
    while (self.subviews.count) {
        UIView * tempView = self.subviews.lastObject;
        [tempView removeFromSuperview];
        
        if (isDestroy) {
            tempView = nil;
        }
    }
}
@end
