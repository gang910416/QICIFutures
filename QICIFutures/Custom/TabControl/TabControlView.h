//
//  TabControlView.h
//  kkcoin
//
//  Created by kk_ghostlord on 2018/4/18.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class TabControlView;
@protocol TabControlViewProtocol <NSObject>
@optional
/**
 点击了选项的回调

 @param tabControlView 选项卡视图
 @param item 被点击的选项按钮
 @param index 当前被点击的选项的下标
 */
- (void)tabControlVeiw:(TabControlView *)tabControlView didSelectedItem:(UIButton *)item index:(NSInteger)index;

/**
 将要点击某个选项的回调，可以控制是否触发点击
 如果返回NO，点击无效，tabControlVeiw:didSelectedItem:index:代理方法不会触发
 默认返回YES

 @param tabControlView 选项卡视图
 @param item 将要点击的选项
 @param index 将要点击的选项下标
 @return 是否需要触发
 */
- (BOOL)tabContolView:(TabControlView *)tabControlView willSeletedItem:(UIButton *)item index:(NSInteger)index;

/**
 自定义选项的代理

 @param tabControlView 选项卡视图
 @param index 当前将要创建的选项的下标
 @param title 当前将要创建的选项的标题
 @return 自定义后的按钮视图
 */
- (UIButton * _Nullable)tabContolView:(TabControlView *)tabControlView willCreateItemAtIndex:(NSInteger)index title:(NSString *)title;

@end

/** 选项卡视图封装 */

@interface TabControlView : UIView

/**
 代理
 */
@property (weak, nonatomic) id<TabControlViewProtocol> delegate;

/**
 当前正在展示的titles
 */
@property (readonly, strong, nonatomic) NSArray *titles;

/**
 当前选中的下标
 */
@property (readonly, assign, nonatomic) NSInteger currentIndex;

/** 选项字体 */
@property (strong, nonatomic) UIFont *btnFont;

/**
 right View
 */
@property (strong, nonatomic) UIView *rightView;

/**
 默认选中的选项下标
 默认是0
 */
@property (assign, nonatomic) NSInteger defaultIndex;

/**
 选项的最小宽度，未达到最小宽度时标题平分显示宽度
 默认为50.0f,
 */
@property (assign, nonatomic) CGFloat itemMinWidth;

/**
 是否显示光标
 */
@property (assign, nonatomic) BOOL isShowCursor;

/**
 cursor Color
 默认为红色
 */
@property (strong, nonatomic) UIColor *cursorColor;

/**
 cursor Inset
 光标的内边距
 */
@property (assign, nonatomic) UIEdgeInsets cursorInset;

/**
 cursor height
 光标高度，默认3.0f
 */
@property (assign, nonatomic) CGFloat cursorHeight;

/**
 光标变化是否使用动画
 默认YES：使用动画
 */
@property (assign, nonatomic) BOOL cursorAnimated;

/**
 默认的标题颜色
 */
@property (strong, nonatomic) UIColor *nomalColor;

/**
 选中的标题颜色
 */
@property (strong, nonatomic) UIColor *selectedColor;

/**
 初始化方法

 @param frame 尺寸
 @param titles 标题数组
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/**
 选中某个下标的选项

 @param index 下标
 @param isDisabled 是否禁用当前选择的代理方法
 */
- (void)selectAtIndex:(NSInteger)index disabledDelegate:(BOOL)isDisabled;

/**
 根据某个标题选中选项

 @param title 标题
 */
- (void)selectAtTitle:(NSString *)title;

/**
 更新标题，根据新的标题重新布局

 @param titles 新的标题数组
 @param isDisabled 禁用此次代理事件
 */
- (void)updateTitles:(NSArray *)titles disabledDelegate:(BOOL)isDisabled;

/**
 更新某个下标的标题
 
 @param title 需要更新为的标题
 @param index 需要更新的选项的下标
 */
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index;

///**
// 展示小红点
//
// @param index 下标
// */
//- (void)showBadgeWithIndex:(NSInteger)index;
//
///**
// 清除小红点
//
// @param index 下标
// */
//- (void)clearBadgeWithIndex:(NSInteger)index;

/**
 更新布局
 */
- (void)updateLayout;

@end

@interface UIView (RemoveAllSubView)

/**
 清除当前的view上所有的子视图

 @param isDestroy 是否将子视图置为空
 */
- (void)removeAllSubViewAndDestroy:(BOOL)isDestroy;

@end

NS_ASSUME_NONNULL_END
