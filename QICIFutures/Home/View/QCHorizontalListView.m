

#import "QCHorizontalListView.h"
#import "QICIMarketCollectionViewCell.h"
#import "QICITitleMoreToolView.h"

@interface QCHorizontalListView ()<UICollectionViewDelegate,UICollectionViewDataSource,ASDTitleMoreToolViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) UIView *headView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) QICITitleMoreToolView *moreView;

@property (strong, nonatomic) UIView *lineView;

@end

static NSString * horizontalListView_collectionView_cell_id_1 = @"horizontalListView_collectionView_cell_id_1";
@implementation QCHorizontalListView


- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier {
    if (self = [super initWithFrame:frame]) {
        
        if (!isStrEmpty(identifier)) {
            self.identifier = identifier;
        }
        
        [self configUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = QICIColorMarketDetail;
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    [self addSubview:self.collectionView];
    [self addSubview:self.moreView];
//    [self addSubview:self.lineView];
    
    [self p_layoutWithMasonry];
}

- (void)p_layoutWithMasonry {
    
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(SCALE_Length(40.0f));
    }];
    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(SCALE_Length(10.0f));
//        make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10.0f));
//        make.top.equalTo()
//    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.moreView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - 公共方法  ----

/**
 更新标题和更多按钮标题
 */
- (void)updateTitle:(NSString *)title moreBtnTitle:(NSString *)moreTitle {
    
    [self.moreView updateTitleString:title moreBtnString:moreTitle];
}

/**
 刷新列表
 */
- (void)reloadListViewWithDataSource:(NSArray *)dataSource {
    
    [self updateDataSource:dataSource];
    
    [self reloadListView];
}

- (void)updateDataSource:(NSArray *)dataSource {
    
    [self.dataSource removeAllObjects];
    
    if (dataSource && dataSource.count > 0) {
        [self.dataSource addObjectsFromArray:dataSource];
    }
}

- (void)reloadListView {
    
    [self.collectionView reloadData];
}

- (void)setDelegate:(id<QICIHorizontalListViewDelegate>)delegate {
    
    if (delegate) {
        _delegate = delegate;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(customCollectionViewCellClassForHorizontalView:)]) {
        Class cellClass = [_delegate customCollectionViewCellClassForHorizontalView:self];
        
        if (cellClass) {
            [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:horizontalListView_collectionView_cell_id_1];
        }
    }
}

- (void)setUpItemSize:(CGSize)itemSize {
    if (!CGSizeEqualToSize(CGSizeZero, itemSize)) {
        self.flowLayout.itemSize = itemSize;
    }
}

#pragma mark - deleagete method --

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QICIMarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:horizontalListView_collectionView_cell_id_1 forIndexPath:indexPath];
    
    // 自定义cell
    if(_delegate && [_delegate respondsToSelector:@selector(customCollectionViewCellClassForHorizontalView:)] && [_delegate respondsToSelector:@selector(horizontalView:setUpCell:dataSource:forItemAtIndexPath:)] && [_delegate customCollectionViewCellClassForHorizontalView:self]) {
        
        [_delegate horizontalView:self setUpCell:cell dataSource:self.dataSource forItemAtIndexPath:indexPath];
        
        return cell;
    }
    
    QICIMarkeModel *model = self.dataSource[indexPath.row];
    [cell updateWithDataModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QICIMarkeModel *model = self.dataSource[indexPath.row];
    
    if(_delegate && [_delegate respondsToSelector:@selector(horizontalView:didSelectedModel:indexPath:)]) {
     
        [_delegate horizontalView:self didSelectedModel:model indexPath:indexPath];
    }
}

#pragma mark - 标题栏的代理方法 --

- (void)titleMoreToolView:(QICITitleMoreToolView *)view didSelectedMoreBtn:(UIButton *)moreBtn {
    if (_delegate && [_delegate respondsToSelector:@selector(horizontalView:didSelectedMoreBtn:)]) {
        [_delegate horizontalView:self didSelectedMoreBtn:moreBtn];
    }
    
    !self.moreActionBlock ? : self.moreActionBlock(self, moreBtn);
}

#pragma mark - 懒加载 ---

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = QICIColorMarketDetail;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[QICIMarketCollectionViewCell class] forCellWithReuseIdentifier:horizontalListView_collectionView_cell_id_1];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(SCALE_Length(150), SCALE_Length(100.0f));
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = SCALE_Length(10.0f);
        _flowLayout.minimumInteritemSpacing = SCALE_Length(10.0f);
        _flowLayout.sectionInset = UIEdgeInsetsMake(SCALE_Length(10.0f), SCALE_Length(10.0f), SCALE_Length(10.0f), SCALE_Length(10.0f));
    }
    return _flowLayout;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (QICITitleMoreToolView *)moreView {
    if (!_moreView) {
        _moreView = [[QICITitleMoreToolView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(40.0f)) titleString:@"热门期货" moreBtnTitle:@"查看更多"];
        _moreView.delegate = self;
    }
    return _moreView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth - SCALE_Length(20.0f), 1.0f)];
        _lineView.backgroundColor = QICIColorSeparator;
    }
    return _lineView;
}


@end
