//
//  RectSelectedView.m
//  kkcoin
//
//  Created by walker on 2018/8/15.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "RectSelectedView.h"
#import "RectSelectedViewCell.h"

@interface RectSelectedView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 选项的标题 */
@property (strong, nonatomic) NSArray *titles;

/** 点阵选项视图 */
@property (strong, nonatomic) UICollectionView *collectionView;

/** 布局对象 */
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

/** 选中的对象下标 */
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@end

static NSString *const rectSelectedViewCell_id_1 = @"rectSelectedViewCell_id_1";
@implementation RectSelectedView


/**
 初始化方法
 
 @param frame 尺寸
 @param titles 选项标题的集合
 */
- (instancetype)initWithFrame:(CGRect)frame itemsTitles:(NSArray <NSString *>*)titles {
    
    if (self = [super initWithFrame:frame]) {
        
        if (titles && titles.count > 0) {
            self.titles = [titles copy];
        }
        
        [self p_asd_configUI];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


#pragma mark - collectionView的代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RectSelectedViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:rectSelectedViewCell_id_1 forIndexPath:indexPath];
    
    cell.cellLabel.text = self.titles[indexPath.row];
    if (self.selectedIndexPath && [self.selectedIndexPath isEqual:indexPath]) {
        [cell setIsSelected:YES];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellTitle = @"";
    if (indexPath.row < self.titles.count) {
        cellTitle = [self.titles objectAtIndex:indexPath.row];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedView:selectedItemTitle:indexPath:)]) {
        [_delegate selectedView:self selectedItemTitle:cellTitle indexPath:indexPath];
    }
    [self setItemSelectedState:YES atIndexPath:indexPath];
}


#pragma mark - 公共方法 --
/**
 设置选中状态
 
 @param isSelected 是否选中
 @param indexPath 选项所在的位置
 */
- (void)setItemSelectedState:(BOOL)isSelected atIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath && indexPath.row < self.titles.count) {
        
        self.selectedIndexPath = indexPath;
        
        [self.collectionView reloadData];
    }
}

#pragma mark - 私有方法 --

- (void)p_asd_configUI {
    
    [self addSubview:self.collectionView];
    
    [self p_layoutWithMasonry];
}

- (void)p_layoutWithMasonry {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

/**
 取消所有cell的选中状态
 */
- (void)p_clearItemSelectedState {
    
    for (RectSelectedViewCell *cell in self.collectionView.visibleCells) {
        [cell setIsSelected:NO];
    }
}

#pragma mark - 懒加载 --

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[];
    }
    return _titles;
}

- (UICollectionView *)collectionView {
    
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[RectSelectedViewCell class] forCellWithReuseIdentifier:rectSelectedViewCell_id_1];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake((kDeviceWidth - SCALE_Length(100.0f)) / 4.0f, SCALE_Length(30.0f));
        _flowLayout.minimumInteritemSpacing = SCALE_Length(10.0f);
        _flowLayout.minimumLineSpacing = SCALE_Length(10.0f);
        _flowLayout.sectionInset = UIEdgeInsetsMake(SCALE_Length(10.0f), SCALE_Length(15.0f), SCALE_Length(10.0f), SCALE_Length(15.0f));
        
    }
    return _flowLayout;
}

@end
