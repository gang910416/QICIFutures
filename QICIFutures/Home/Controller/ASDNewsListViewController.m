//
//  ASDNewsListViewController.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/29.
//  Copyright © 2019 ASD. All rights reserved.
//

#import "ASDNewsListViewController.h"
#import "ASDNewsViewController.h"
#import "QCHomeDataMannger.h"
#import "ASDNewsListCell.h"
#import "ASDNewsListModel.h"
#import "GLRefreshFooter.h"
@interface ASDNewsListViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (assign , nonatomic) ASDSimulateRankType rankType;

@property (strong, nonatomic) UITableView *listView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIButton *noDataBtn;

/** 是否是刷新数据 */
@property (assign, nonatomic) BOOL isRefresh;
/** 当前的最旧的newsid */
@property (strong, nonatomic) NSString *newsId;
/** 快讯 */
@property (strong, nonatomic) UIButton *fastNewsBtn;

/** 是否需要返回按钮 */
@property (assign, nonatomic) BOOL isNeedBackBtn;

@end

static NSString *const ASDNewsListViewCell_id_1 = @"ASDNewsListViewCell_id_1";

@implementation ASDNewsListViewController

/**
 是否需要返回按钮
 
 @param needBackBtn 是否需要返回按钮
 */
- (instancetype)initWithNeedBackBtn:(BOOL)needBackBtn {
    
    if (self = [super init]) {
        
        self.isNeedBackBtn = needBackBtn;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewDid_adf:@(arc4random() % 100)  num:@(10) arg:@"asd"];
    
    UIImage * img = [UIImage imageNamed:@"icon_ASD_7"];
    
    if(img) {
        self.view.alpha = 1.0f;
    }
    
    self.isHiddenShadow = NO;
    self.isHiddenBar = NO;
    self.isHiddenTitleView = NO;
    self.navTitleSting = @"资讯";
    self.newsId = @"0";
    if (self.isNeedBackBtn) {
        self.isHiddenBackButton = NO;
    }else {
        self.isHiddenBackButton = YES;
    }
    
    self.view.backgroundColor = QICIColorMarketDetail;
    
    [self p_asd_configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self p_loadDataFromNet];
    
}



- (void)p_asd_configUI {
    
    [self.view addSubview:self.listView];
    [self.navTitleView addSubview:self.fastNewsBtn];
    
    [self.fastNewsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(SCALE_Length(- 20.0f));
        make.centerY.equalTo(self.navTitleView);
        make.size.mas_equalTo(CGSizeMake(80.0f, 44.0f));
    }];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(Nav_topH);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)p_loadDataFromNet {
    
    [SVProgressHUD show];
    weakSelf(self);
    [QCHomeDataMannger getHomeNewsWithSinceId:self.newsId count:20 blockSuccess:^(NSArray<ASDNewsListModel *> * _Nonnull list) {
        
        [SVProgressHUD dismiss];
                [weakSelf.listView.mj_header endRefreshing];
                [weakSelf.listView.mj_footer endRefreshing];
        
                [weakSelf p_processDataWithList:list];
        
        
        
    } faild:^(NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
                [weakSelf.listView.mj_header endRefreshing];
                [weakSelf.listView.mj_footer endRefreshing];
        
                [weakSelf p_updateNoDataBtnState];
        
    }];
    
    
}
- (void)p_processDataWithList:(NSArray *)list {
    
    if (list && list.count > 0) {
        if (self.isRefresh) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:list];
        }else {
            [self.dataSource addObjectsFromArray:list];
        }
        weakSelf(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.listView reloadData];
            [weakSelf p_updateNoDataBtnState];
        });
    }
    
    self.isRefresh = NO;
}



- (void)p_updateNoDataBtnState {
    
    if (self.dataSource && self.dataSource.count > 0) {
        self.noDataBtn.hidden = YES;
        [self.noDataBtn removeFromSuperview];
    }else {
        self.noDataBtn.hidden = NO;
        if (![self.listView.subviews containsObject:self.noDataBtn]) {
            
            [self.listView addSubview:self.noDataBtn];
        }
        
        [self.noDataBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.listView.mas_centerX);
            make.centerY.equalTo(self.listView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(SCALE_Length(200.0f), SCALE_Length(200.0f)));
        }];
    }
}



- (void)p_noDataBtnAction:(UIButton *)btn {
    
    // 无数据点击事件
    [self p_loadNewData];
    
}

- (void)p_loadNewData {
    
    self.isRefresh = YES;
    
    [self p_loadDataFromNet];
}

- (void)p_fastNewsBtnAction:(UIButton *)btn {
    
    QICIBaseWebViewController *fastNewsVC = [[QICIBaseWebViewController alloc] initWithUrl:@"https://m.fxinz.com/zh/news.html?app=gts2_app_orig&consulting=1&deviceId=&version=100&terminal=ios"];
    fastNewsVC.hidesBottomBarWhenPushed = YES;
    fastNewsVC.title = @"快讯";
    fastNewsVC.webView.scrollView.bounces = NO;
    [self.navigationController pushViewController:fastNewsVC animated:YES];
}

#pragma mark - tableiview delegate ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASDNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:ASDNewsListViewCell_id_1 forIndexPath:indexPath];
    ASDNewsListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCALE_Length(90.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ASDNewsListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if (model) {
        
        ASDNewsViewController *detailVC = [[ASDNewsViewController alloc] initWithNewsId:model.newsId];
        detailVC.title = model.title;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - lazy load ---
- (UITableView *)listView {
    
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _listView.backgroundColor = QICIColorMarketDetail;
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.delegate = self;
        _listView.dataSource = self;
        [_listView registerClass:[ASDNewsListCell class] forCellReuseIdentifier:ASDNewsListViewCell_id_1];
        _listView.mj_header = [GLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(p_loadNewData)];
        _listView.mj_footer = [GLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(p_loadDataFromNet)];
    }
    return _listView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (UIButton *)noDataBtn {
    if (!_noDataBtn) {
        _noDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCALE_Length(200.0f), SCALE_Length(200.0f))];
        _noDataBtn.titleLabel.font = [UIFont fontWithName:fFont size:15.0f];
        [_noDataBtn setTitle:@"加载失败了，点击重试" forState:UIControlStateNormal];
        [_noDataBtn addTarget:self action:@selector(p_noDataBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_noDataBtn setTitleColor:QICIColorTipText forState:UIControlStateNormal];
    }
    return _noDataBtn;
}

- (UIButton *)fastNewsBtn {
    
    if (!_fastNewsBtn) {
        _fastNewsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80.0f, 44.0f)];
        [_fastNewsBtn setTitle:@"24h快讯" forState:UIControlStateNormal];
        [_fastNewsBtn setTitleColor:QICIColorTitle forState:UIControlStateNormal];
        _fastNewsBtn.titleLabel.font = [UIFont fontWithName:fFont size:15.0f];
        [_fastNewsBtn addTarget:self action:@selector(p_fastNewsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fastNewsBtn;
}

@end
