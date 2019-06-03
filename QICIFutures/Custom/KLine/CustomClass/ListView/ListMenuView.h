//
//  ListMenuView.h
//  GLKLineKit
//
//  Created by walker on 2018/5/31.
//  Copyright © 2018年 walker. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class ListMenuView;
@protocol ListMenuViewProtocol <NSObject>
@optional
/**
 被选中的选项

 @param view 选项列表视图
 @param indexPath 选择的位置
 @param title 选项的标题
 */
- (void)listMenuView:(ListMenuView *)view didSelectedAtIndexPath:(NSIndexPath *)indexPath itemTitle:(NSString *)title;

/**
 选项的标题集合

 @param view 选项列表视图
 */
- (NSArray *)itemTitlesAtListMenuView:(ListMenuView *)view;


/**
 根据位置设置分区头标题

 @param section 分区位置
 */
- (NSString *)listMenuView:(ListMenuView *)view sectionTitleAtSection:(NSInteger)section;

/**
 每个分区的高度

 @param section 分区数
 */
- (CGFloat)listMenuView:(ListMenuView *)view heightForSectionHeaderViewAtSection:(NSInteger)section;

/**
 分区区头视图

 @param section 分区位置
 */
- (UIView *)listMenuView:(ListMenuView *)view sectionHeaderViewAtSection:(NSInteger)section;

@end

/**
 简单列表视图
 */
@interface ListMenuView : UIView

/** 视图的唯一标识符 */
@property (readonly, copy, nonatomic) NSString *identifier;

/** 字体对象 */
@property (strong, nonatomic) UIFont *textFont;

/** 字体颜色 */
@property (strong, nonatomic) UIColor *textColor;

/** 字体对齐方式 */
@property (assign, nonatomic) NSTextAlignment textAlignment;

/** cell 高度 */
@property (assign, nonatomic) CGFloat heightForRow;

/** 代理 */
@property (weak, nonatomic) id<ListMenuViewProtocol> delegate;

/** 是否有分割线 */
@property (assign, nonatomic) BOOL isShowSeparator;

/**
 初始化方法

 @param frame 尺寸
 @param identifier 标识符
 */
- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

/**
 更新标识符

 @param identifier 标识符
 */
- (void)updateIdentifier:(NSString *)identifier;

/**
 刷新源数据
 */
- (void)reloadListData;

/**
 设置选中样式

 @param isSelected 是否选中
 @param indexPath 设置的选项的位置
 @param clean   是否清除当前分区的其他选项选中状态
 */
- (void)setSelectedState:(BOOL)isSelected forIndexPath:(NSIndexPath *)indexPath cleanOtherItemCurrentSection:(BOOL)clean;

/**
 清除选中状态
 */
- (void)cleanSelectedState;

/**
 展示小红点
 
 @param index 下标
 */
- (void)showBadgeWithIndex:(NSIndexPath *)index;

/**
 清除小红点
 
 @param index 下标
 */
- (void)clearBadgeWithIndex:(NSIndexPath *)index;


#pragma mark - 禁用的方法 ---

/**
 初始化方法请使用 initWithFrame:identifier:方法初始化
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 初始化方法请使用 initWithFrame:identifier:方法初始化
 */
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/**
 初始化方法请使用 initWithFrame:identifier:方法初始化
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end


#pragma mark - 菜单标题cell -----
@interface ListMenuViewCell : UITableViewCell

/**
 TitleLabel
 */
@property (readonly, strong, nonatomic) UILabel *titleLabel;

/**
 是否显示分割线
 */
@property (assign, nonatomic) BOOL isShowSeparator;

@end
NS_ASSUME_NONNULL_END
