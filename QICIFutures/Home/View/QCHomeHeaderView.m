//
//  QCHomeHeaderView.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "QCHomeHeaderView.h"
#import "QCBtnSView.h"
@interface QCHomeHeaderView ()<HOMEBTNSViewDelegate,QICIHorizontalListViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *qcCycleView;
@property (strong, nonatomic) JhtVerticalMarquee *paoMaView;
@property (strong, nonatomic) NSMutableArray *newsDataArray;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) QCBtnSView *mapView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIView *secondLineView;
@property (strong, nonatomic) UIView *endLineView;
@property (strong, nonatomic) UIView *mapLineView;

@property (nonatomic,strong) UIView *infoMationView;
@property (strong, nonatomic) QCHorizontalListView *horizontalListView;

@property (strong, nonatomic) NSMutableArray *indexListModels;

@end

#define BannerScrollViewHeight (SCALE_Length(120.0f))
#define kMapViewHeight      (SCALE_Length(140.0f))


@implementation QCHomeHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        [self configUI];
        
        [self updateNewData];
    }
    return self;
}


-(void)configUI{
    [self addSubview:self.qcCycleView];
    [self.qcCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(10.0f));
        make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10.0f));
        make.top.equalTo(self.mas_top).offset(5);
        make.height.mas_equalTo(BannerScrollViewHeight);
    }];
    [self addSubview:self.lineView];
    [self addSubview:self.imgView];
    [self addSubview:self.paoMaView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.qcCycleView.mas_bottom);
        make.height.mas_equalTo(SCALE_Length(10.0f));
    }];
    
    [self.paoMaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.equalTo(self.mas_left).offset(SCALE_Length(35.0f));
        make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10));
        make.height.mas_equalTo(SCALE_Length(40.0f));
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(15.0f));
        make.centerY.equalTo(self.paoMaView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SCALE_Length(20.0f), SCALE_Length(20.0f)));
    }];
    
     [self addSubview:self.secondLineView];
    [self.secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.paoMaView.mas_bottom);
        make.height.mas_equalTo(SCALE_Length(10.0f));
    }];
    
     [self addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.secondLineView.mas_bottom);
        make.height.mas_equalTo(kMapViewHeight);
    }];
    
      [self addSubview:self.mapLineView];
    [self.mapLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mapView.mas_bottom).offset(SCALE_Length(-60));
        make.height.mas_equalTo(SCALE_Length(0.0f));
    }];
    [self addSubview:self.infoMationView];
    [self.infoMationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(10.0f));
        make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10.0f));
        make.top.equalTo(self.mapLineView.mas_bottom).offset(SCALE_Length(10.0f));
        make.height.mas_equalTo(160);
    }];
    [self addSubview:self.horizontalListView];
    [self.horizontalListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(10.0f));
        make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10.0f));
        make.top.equalTo(self.infoMationView.mas_bottom).offset(SCALE_Length(10.0f));
        make.height.mas_equalTo(160);
    }];
    
    //    self.horizontalListView.backgroundColor = [UIColor redColor];
    [self addSubview:self.endLineView];
    
    [self.endLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.horizontalListView.mas_bottom);
        make.height.mas_equalTo(SCALE_Length(10.0f));
    }];
}

- (void)reloadData{
     [self updateNewData];
}

-(void)updateNewData{
    
    weakSelf(self);
    [QCHomeDataMannger getHomeNewsWithSinceId:@"" count:5 blockSuccess:^(NSArray<QCNewsListModel *> * _Nonnull list) {
        [weakSelf.newsDataArray removeAllObjects];
        [weakSelf.newsDataArray addObjectsFromArray:list];
        [weakSelf refreshUI];
    } faild:^(NSError * _Nonnull error) {
        
    }];
    // 指数
    [QCHomeDataMannger getMarketIndexWithBlockSuccess:^(NSArray<QICIMarkeModel *> * _Nonnull list) {
        NSArray *indexList = [list subarrayWithRange:NSMakeRange(0, 4)];
        
        [weakSelf p_refreshHorizontalListViewWithIndexList:indexList];
        
    } faild:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:NetErrorTipString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.horizontalListView gl_stopAnimating];
        });
    }];
    
}

- (void)p_refreshHorizontalListViewWithIndexList:(NSArray *)indexList {
    
    [self.indexListModels removeAllObjects];
    [self.indexListModels addObjectsFromArray:indexList];
    
    [self.horizontalListView reloadListViewWithDataSource:indexList];
    [self.horizontalListView gl_stopAnimating];
}

-(void)refreshUI{
    if (self.newsDataArray.count  >  0) {
        
        //清空图片 标题数组
        [self.imagesArray removeAllObjects];
        [self.titlesArray removeAllObjects];
        
        for (int i = 0; i< self.newsDataArray.count; i ++ ) {
            QCNewsListModel *newsModel = [self.newsDataArray objectAtIndex:i];
            [self.imagesArray addObject:newsModel.imgsrc1? : @""];
            [self.titlesArray addObject:newsModel.title ? : @""];
        }
        [self.qcCycleView setImageURLStringsGroup:self.imagesArray];
        [self.qcCycleView setTitlesGroup:self.titlesArray];
        
    }
    // 跑马灯倒序展示标题
    NSEnumerator *enumerator = [self.titlesArray reverseObjectEnumerator];
    [self.paoMaView setSourceArray:[enumerator allObjects]];
    [self.paoMaView marqueeOfSettingWithState:MarqueeStart_V];
}
/** 轮播点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if(self.newsDataArray.count > index) {
        QCNewsDetailModel *model = [self.newsDataArray objectAtIndex:index];
        
        !self.newsSelectedBlock ? : self.newsSelectedBlock(model);
    }
}
#pragma mark - horzontal delegate method --

- (void)horizontalView:(QCHorizontalListView *)listView didSelectedMoreBtn:(UIButton *)moreBtn {
    
    !self.indexSelectedBlock ? : self.indexSelectedBlock(nil, YES);
}

- (void)horizontalView:(QCHorizontalListView *)listView didSelectedModel:(QICIMarkeModel *)model indexPath:(NSIndexPath *)indexPath {
    
    !self.indexSelectedBlock ? : self.indexSelectedBlock(model, NO);
}

-(void)delegate_touchBtnWithIndex:(NSInteger)index {
    
    !self.mapViewSelectedBlock ? : self.mapViewSelectedBlock(index);
}
/* 跑马灯点击事件 */
- (void)selectedMarqueeView:(UITapGestureRecognizer *)tap {
    
    if (self.newsDataArray.count > self.paoMaView.currentIndex) {
        NSInteger index = (self.newsDataArray.count - 1) - self.paoMaView.currentIndex;
        QCNewsListModel *model = [self.newsDataArray objectAtIndex:index];
        
        !self.newsSelectedBlock ? : self.newsSelectedBlock(model);
    }
}

#pragma  -----懒加载

- (NSMutableArray *)newsDataArray {
    if (!_newsDataArray) {
        _newsDataArray = @[[QCNewsListModel createHomeNewsModel]].mutableCopy;
    }
    return _newsDataArray;
}
- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = @[@"https://n.sinaimg.cn/translate/105/w600h305/20190418/lqZ3-hvvuiyn0197134.jpg"].mutableCopy;
    }
    return _imagesArray;
}

- (NSMutableArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[@"国常会新定调：近期或出台针对中小银行定向降准？"].mutableCopy;
    }
    return _titlesArray;
}

- (SDCycleScrollView *)qcCycleView {
    
    if (!_qcCycleView) {
        _qcCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth - SCALE_Length(20.0f), BannerScrollViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeHolder_stock"]];
        _qcCycleView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        _qcCycleView.titleLabelHeight = SCALE_Length(40.0f);
        _qcCycleView.autoScrollTimeInterval = 4.0f;
        _qcCycleView.titleLabelTextAlignment = NSTextAlignmentCenter;
        _qcCycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _qcCycleView.layer.cornerRadius = SCALE_Length(3.0f);
        _qcCycleView.layer.masksToBounds = YES;
    }
    return _qcCycleView;
}
- (JhtVerticalMarquee *)paoMaView {
    if (!_paoMaView ) {
        _paoMaView = [[JhtVerticalMarquee alloc] initWithFrame:CGRectMake(SCALE_Length(20.0f), BannerScrollViewHeight, kDeviceWidth - SCALE_Length(40.0f), SCALE_Length(40.0f))];
        _paoMaView.textAlignment = NSTextAlignmentCenter;
        _paoMaView.scrollDuration = 3.0f;
        _paoMaView.backgroundColor = QICIColorMarketDetail;
        _paoMaView.textColor = QICIColorTitle;
        _paoMaView.isCounterclockwise = YES;
        [_paoMaView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedMarqueeView:)]];
    }
    return _paoMaView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(10.0f))];
        _lineView.backgroundColor = QICIColorGap;
    }
    return _lineView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_msg"]];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.backgroundColor = ClearColor;
    }
    return _imgView;
}

- (UIView *)secondLineView {
    if (!_secondLineView) {
        _secondLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(10.0f))];
        _secondLineView.backgroundColor = QICIColorGap;
    }
    return _secondLineView;
}
- (UIView *)mapLineView {
    if (!_mapLineView) {
        _mapLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _mapLineView.backgroundColor = QICIColorGap;
    }
    return _mapLineView;
}
- (QCBtnSView *)mapView {
    if (!_mapView) {
        _mapView = [[QCBtnSView alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, SCALE_Length(80.0f)) titles:@[@"国内期货",@"国际期货",@"股指期货",@"快讯"] icons:@[@"icon_home_profit",@"icon_home_short",@"icon_home_suc",@"icon_home_simulate"]];
        _mapView.backgroundColor = QICIColorGap;
        _mapView.delegate = self;
    }
    return _mapView;
}


- (UIView *)endLineView {
    if (!_endLineView) {
        _endLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(70.0f))];
        _endLineView.backgroundColor = QICIColorGap;
    }
    return _endLineView;
}

- (UIView *)infoMationView {
    if (!_infoMationView) {
        _infoMationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(160))];
        _infoMationView.backgroundColor = ClearColor;
        NSArray *imageArray = @[@"newTeach",@"dealRule",@"about"];
        for (int i = 0; i < 3; i++ ) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            btn.tag =  10 + i;
            [btn addTarget:self  action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.infoMationView addSubview:btn];
            if (i == 0) {
                btn.frame = CGRectMake(0, 0, (kDeviceWidth - 20)/2, SCALE_Length(160));
            }else{
                btn.frame = CGRectMake(kDeviceWidth/2, (i - 1)*SCALE_Length(80), (kDeviceWidth - 30)/2, SCALE_Length(78));
            }
        }
    }
    return _infoMationView;
}

-(void)btnClick:(UIButton *)sider{
    if (_btnSelectedBlock) {
        self.btnSelectedBlock(sider.tag);
    }
}

- (QCHorizontalListView *)horizontalListView {
    if (!_horizontalListView) {
        _horizontalListView = [[QCHorizontalListView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(160))];
        _horizontalListView.delegate = self;
    }
    return _horizontalListView;
}

- (NSMutableArray *)indexListModels {
    if (!_indexListModels) {
        _indexListModels = @[].mutableCopy;
    }
    return _indexListModels;
}

@end
