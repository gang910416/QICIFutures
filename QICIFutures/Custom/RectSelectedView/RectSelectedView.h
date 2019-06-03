//
//  RectSelectedView.h
//  kkcoin
//
//  Created by walker on 2018/8/15.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//


@class RectSelectedView;
@protocol RectSelectedViewProtocol<NSObject>
@required
/**
 选中的选项

 @param selectedView 选择视图
 @param title 选中选项的标题
 @param indexPath 选中选项的下标
 */
- (void)selectedView:(RectSelectedView *)selectedView selectedItemTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end

@interface RectSelectedView : UIView

/** 代理 */
@property (strong, nonatomic) id <RectSelectedViewProtocol> delegate;

/**
 初始化方法

 @param frame 尺寸
 @param titles 选项标题的集合
 */
- (instancetype)initWithFrame:(CGRect)frame itemsTitles:(NSArray <NSString *>*)titles;

/**
 设置选中状态

 @param isSelected 是否选中
 @param indexPath 选项所在的位置
 */
- (void)setItemSelectedState:(BOOL)isSelected atIndexPath:(NSIndexPath *)indexPath;

@end
