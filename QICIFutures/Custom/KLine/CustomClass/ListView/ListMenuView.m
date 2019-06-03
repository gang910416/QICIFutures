//
//  ListMenuView.m
//  GLKLineKit
//
//  Created by walker on 2018/5/31.
//  Copyright © 2018年 walker. All rights reserved.
//

#import "ListMenuView.h"

@interface ListMenuView ()<UITableViewDelegate,UITableViewDataSource>

/**
 列表
 */
@property (strong, nonatomic) UITableView *listView;

/**
 数据
 */
@property (strong, nonatomic) NSArray *dataSource;

/**
 视图的唯一标识符
 */
@property (readwrite, copy, nonatomic) NSString *identifier;

/**
 选中的下标集合
 */
@property (strong, nonatomic) NSMutableSet *selectedIndexPaths;

/**
 分区间隔
 */
@property (assign, nonatomic) CGFloat sectionGap;

/** 小红点所在的indexPath */
@property (strong, nonatomic) NSIndexPath *badgeIndex;

@end

static NSString *const listViewCell_id_1 = @"listViewCell_id_1";
@implementation ListMenuView

- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier {
    
    if (self = [super initWithFrame:frame]) {
        
        if (identifier) {
            self.identifier = identifier;
        }
        
        if (@available(iOS 11.0, *)) {
            self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.heightForRow = 44.0f;
        self.sectionGap = 1.0f;
        
        [self p_asd_configUI];
    }
    
    return self;
}

#pragma mark - 布局方法  -------

- (void)p_asd_configUI {
    
    [self addSubview:self.listView];
    
    [self p_layoutWithMasonry];
}


- (void)p_layoutWithMasonry {
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5.0f);
        make.right.equalTo(self.mas_right).offset(- 5.0f);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - UITableViewDelegate --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.dataSource.count <= 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(itemTitlesAtListMenuView:)]) {
            NSArray *tempData = [_delegate itemTitlesAtListMenuView:self];
            if (tempData && tempData.count > 0) {
                self.dataSource = [tempData copy];
            }
        }
    }
    
    if ([[self.dataSource firstObject] isKindOfClass:[NSArray class]]) {
        NSInteger allCount = 0;
        for (NSArray *tempArray in self.dataSource) {
            allCount += tempArray.count;
        }
        
        if(self.heightForRow <= 0) {
            self.heightForRow = (self.frame.size.height - ((self.dataSource.count - 1) * self.sectionGap)) / allCount;
            self.heightForRow = self.heightForRow < 44.0f ? 44.0f : self.heightForRow;
        }
        
        return self.dataSource.count;
    }else {
        if (self.heightForRow <= 0) {
            self.heightForRow = self.frame.size.height / self.dataSource.count;
            self.heightForRow = self.heightForRow < 44.0f ? 44.0f : self.heightForRow;
        }
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[self.dataSource firstObject] isKindOfClass:[NSArray class]]) {
        return [self.dataSource[section] count];
    }else {
        return self.dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListMenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCell_id_1 forIndexPath:indexPath];
    NSString *title = @"";
    if ([[self.dataSource firstObject] isKindOfClass:[NSArray class]]) {
        title = [self.dataSource[indexPath.section] objectAtIndex:indexPath.row];
    }else {
        title = [self.dataSource objectAtIndex:indexPath.row];
    }
    cell.titleLabel.text = title;
    cell.titleLabel.textAlignment = self.textAlignment;
    cell.titleLabel.textColor = self.textColor;
    cell.isShowSeparator = self.isShowSeparator;
    cell.titleLabel.font = self.textFont;
    if(self.selectedIndexPaths.count >= 1) {
        NSString *indexString = [NSString stringWithFormat:@"%ld_%ld",indexPath.section,indexPath.row];
        if ([self.selectedIndexPaths containsObject:indexString]) {
            cell.titleLabel.textColor = QICIColorTheme;
        }
    }
    
    if (self.badgeIndex && [self.badgeIndex isEqual:indexPath]) {
//        [cell.titleLabel showBadge];
//        [cell.titleLabel setBadgeCenterOffset:CGPointMake(SCALE_Length(- 15.0), SCALE_Length(5.0f))];
    }else {
//        [cell.titleLabel clearBadge];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.heightForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = @"";
    if ([[self.dataSource firstObject] isKindOfClass:[NSArray class]]) {
        title = [self.dataSource[indexPath.section] objectAtIndex:indexPath.row];
    }else {
        title = [self.dataSource objectAtIndex:indexPath.row];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(listMenuView:didSelectedAtIndexPath:itemTitle:)]) {
        [_delegate listMenuView:self didSelectedAtIndexPath:indexPath itemTitle:title];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    if (_delegate && [_delegate respondsToSelector:@selector(listMenuView:sectionTitleAtSection:)]) {
        title = [_delegate listMenuView:self sectionTitleAtSection:section];
    }
    
    return title;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *sectionView = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(listMenuView:sectionHeaderViewAtSection:)]) {
        sectionView = [_delegate listMenuView:self sectionHeaderViewAtSection:section];
    }
    return sectionView;
}

/* 分区高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0.0001f;
    if (_delegate && [_delegate respondsToSelector:@selector(listMenuView:heightForSectionHeaderViewAtSection:)]) {
        height = [_delegate listMenuView:self heightForSectionHeaderViewAtSection:section];
    }
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - 赋值或set方法 ----

- (void)setIsShowSeparator:(BOOL)isShowSeparator {
    _isShowSeparator = isShowSeparator;
    [self.listView reloadData];
}

- (void)setTextFont:(UIFont *)textFont {
    if (textFont) {
        _textFont = textFont;
        [self.listView reloadData];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if(textColor) {
        _textColor = textColor;
        [self.listView reloadData];
    }
}

- (void)setHeightForRow:(CGFloat)heightForRow {
    if (heightForRow > 0) {
        _heightForRow = heightForRow;
    }
}

#pragma mark - 公共方法 -----
/**
 刷新源数据
 */
- (void)reloadListData {
    self.dataSource = @[];
    [self.selectedIndexPaths removeAllObjects];
    [self.listView reloadData];
}

/**
 设置选中样式
 
 @param isSelected 是否选中
 @param indexPath 设置的选项的位置
 @param clean   是否清除当前分区的其他选项选中状态
 */
- (void)setSelectedState:(BOOL)isSelected forIndexPath:(NSIndexPath *)indexPath cleanOtherItemCurrentSection:(BOOL)clean {
    
    // 坐标字符串
    NSString *string = [NSString stringWithFormat:@"%ld_%ld",indexPath.section,indexPath.row];
    
    if(clean) {
        for (NSString *tempObject in [self.selectedIndexPaths copy]) {
            if (!isStrEmpty([@(indexPath.section) stringValue])) {
                if ([tempObject hasPrefix:[@(indexPath.section) stringValue]]) {
                    [self.selectedIndexPaths removeObject:tempObject];
                }
            }
        }
    }
    
    if (isSelected) {
        [self.selectedIndexPaths addObject:string];
    }else {
        [self.selectedIndexPaths removeObject:string];
    }
    
    [self.listView reloadData];
}

/**
 更新标识符
 
 @param identifier 标识符
 */
- (void)updateIdentifier:(NSString *)identifier {
    
    if(identifier && identifier.length > 0) {
        self.identifier = identifier;
    }
}

/**
 清除选中状态
 */
- (void)cleanSelectedState {
    
    [self.selectedIndexPaths removeAllObjects];
    
    [self.listView reloadData];
}

/**
 展示小红点
 
 @param index 下标
 */
- (void)showBadgeWithIndex:(NSIndexPath *)index {
    
    ListMenuViewCell * cell = [self.listView cellForRowAtIndexPath:index];
    
    if (cell) {
        self.badgeIndex = index;
        
        [self.listView reloadData];
    }
}

/**
 清除小红点
 
 @param index 下标
 */
- (void)clearBadgeWithIndex:(NSIndexPath *)index {
    
    
    ListMenuViewCell * cell = [self.listView cellForRowAtIndexPath:index];
    
    if (cell) {
        self.badgeIndex = nil;
//        [cell.titleLabel clearBadge];
    }
}


#pragma mark - 其他私有方法 ----


#pragma mark - 懒加载 ---------

- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = [UIColor clearColor];
        [_listView registerClass:[ListMenuViewCell class] forCellReuseIdentifier:listViewCell_id_1];
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.bounces = NO;
    }
    return _listView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (NSMutableSet *)selectedIndexPaths {
    if (!_selectedIndexPaths) {
        _selectedIndexPaths = [[NSMutableSet alloc] init];
    }
    return _selectedIndexPaths;
}

@end

#pragma mark - 菜单标题cell  ---
@interface ListMenuViewCell ()

/**
 TitleLabel
 */
@property (readwrite, strong, nonatomic) UILabel *titleLabel;

/**
 分割线
 */
@property (strong, nonatomic) UIView *separatorView;
@end
@implementation ListMenuViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self cell_wrfg:@[@"2",@"3"]  string:@"qwert" num:@(0)];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self p_asd_configUI];
        
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.textColor = QICIColorSeparator;
}


- (void)p_asd_configUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.separatorView];
    
    [self p_layoutWithMasonry];
    
}

- (void)p_layoutWithMasonry {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)setIsShowSeparator:(BOOL)isShowSeparator {
    _isShowSeparator = isShowSeparator;
    self.separatorView.hidden = !_isShowSeparator;
}

#pragma mark - 懒加载 ---

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = QICIColorTipText;
    }
    return _titleLabel;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _separatorView.backgroundColor = QICIColorTitle;
    }
    return _separatorView;
}

@end
