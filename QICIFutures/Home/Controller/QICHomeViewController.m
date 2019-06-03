//
//  QICHomeViewController.m
//  QICIFutures
//
//  Created by mac on 2019/5/31.
//

#import "QICHomeViewController.h"
#import "QCHomeHeaderView.h"
#import "QICIMarketListSectionHeaderView.h"
#import "QCNewsViewController.h"
#import "ASDNewsListViewController.h"
#import "ASDNewsListModel.h"
#import "ASDNewsViewController.h"
#import "ASDNewsListCell.h"
@interface QICHomeViewController ()<
UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *li_dataArray;
@property (strong, nonatomic) NSMutableArray *newsDataSource;
@property (strong, nonatomic) GLRefreshHeader *listRefreshHeader;
@property (strong, nonatomic) UIScrollView *contentView;
/** 搜索按钮  */
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) QCHomeHeaderView *headerView;
/** 是否是刷新数据 */
@property (assign, nonatomic) BOOL isRefresh;
/** sectionView */
@property (strong, nonatomic) QICIMarketListSectionHeaderView *sectionView;
@property (strong, nonatomic) NSString *newsId;
@end

static NSString *const ASDNewsListViewCell_id_1 = @"ASDNewsListViewCell_id_1";
@implementation QICHomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.newsId = @"0";
    self.isRefresh= YES;
    [self  lg_configUi];
    [self getNewsData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromNetWork];
    [self.headerView reloadData];
}

-(void)getDataFromNetWork{
    
    [self.listRefreshHeader endRefreshing];
    weakSelf(self);
    [QCHomeDataMannger getHomeMarketListWithMarket:@"commodity" isAsce:YES reqCount:10 blockSuccess:^(NSArray<QICIMarkeModel *> * _Nonnull list) {
        [weakSelf.listRefreshHeader endRefreshing];
        if (list) {
            weakSelf.li_dataArray = [list mutableCopy];
        }
        
        [self.tableView reloadData];
    } blockfaild:^(NSError * _Nonnull error) {
        
    }];
    
    
}

-(void)getNewsData{
    [SVProgressHUD show];
    weakSelf(self);
    [QCHomeDataMannger getHomeNewsWithSinceId:self.newsId count:20 blockSuccess:^(NSArray<ASDNewsListModel *> * _Nonnull list) {
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        self.newsDataSource = [list mutableCopy];
        [weakSelf p_processDataWithList:list];
        
    } faild:^(NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];

}
- (void)p_processDataWithList:(NSArray *)list {
    
    if (list && list.count > 0) {
        if (self.isRefresh) {
            [self.newsDataSource removeAllObjects];
            [self.newsDataSource addObjectsFromArray:list];
        }else {
            [self.newsDataSource addObjectsFromArray:list];
        }
        weakSelf(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }
    
    self.isRefresh = NO;
}

-(void)lg_configUi{
    
     [self.view addSubview:self.searchButton];
     [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navTitleView.mas_centerX);
        make.centerY.equalTo(self.navTitleView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth - 40, 30.0f));
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(Nav_topH);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}




#pragma ------按钮点击事件

-(void)homeSearchBtnAction:(UIButton *)btn{
    
    NSArray *searchHotArray = @[@"AU9999.SGE",@"AGTD.SGE",@"CNA50F.OTC",@"天然气",@"玉米"];
    
    PYSearchViewController *pysearchVc = [PYSearchViewController searchViewControllerWithHotSearches:searchHotArray searchBarPlaceholder:@"输入完整的期货或代码" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
         [SVProgressHUD show];
        
    }];
//    [SVProgressHUD dismiss];
    pysearchVc.view.backgroundColor = QICIColorMarketDetail;
    // 3. present the searchViewController
    UINavigationController *searchnav = [[UINavigationController alloc] initWithRootViewController:pysearchVc];
    searchnav.navigationBar.barTintColor =QICIColorTheme;
    [self presentViewController:searchnav  animated:NO completion:nil];
}


#pragma mark - tableiview delegate ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASDNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:ASDNewsListViewCell_id_1 forIndexPath:indexPath];
    ASDNewsListModel *model = [self.newsDataSource objectAtIndex:indexPath.row];
    [cell updateDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCALE_Length(90.0f);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCALE_Length(20.0f);
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    return self.sectionView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ASDNewsListModel *model = [self.newsDataSource objectAtIndex:indexPath.row];
    
    if (model) {
        
        ASDNewsViewController *detailVC = [[ASDNewsViewController alloc] initWithNewsId:model.newsId];
        detailVC.title = model.title;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


#pragma  --------------懒加载

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, SCALE_Length(240.0f), 30.0f)];
        _searchButton.backgroundColor = [QICIColorBackGround colorWithAlphaComponent:0.4];
        [_searchButton setTitle:@" 点击此处搜索期货" forState:UIControlStateNormal];
        _searchButton.titleLabel.font = [UIFont fontWithName:fFont size:12.0f];
        [_searchButton setImage:[UIImage imageNamed:@"icon_nav_search_bar"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(homeSearchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _searchButton.layer.borderColor = QICIColorBorder.CGColor;
        _searchButton.layer.borderWidth = 0.5f;
        _searchButton.layer.cornerRadius = 15.0f;
        _searchButton.layer.masksToBounds = YES;
    }
    return _searchButton;
}

- (QICIMarketListSectionHeaderView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[QICIMarketListSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(40.0f)) titles:@[@"涨幅榜",@"最新价",@"涨跌幅"]];
    }
    return _sectionView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _listView.backgroundColor = [UIColor redColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.mj_header = self.listRefreshHeader;
        [_tableView registerClass:[ASDNewsListCell class] forCellReuseIdentifier:ASDNewsListViewCell_id_1];
    }
    return _tableView;
}


- (QCHomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[QCHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(490.0f)+ SCALE_Length(120))];
        weakSelf(self);
//                _headerView.backgroundColor = [UIColor redColor];
        _headerView.newsSelectedBlock = ^(QCNewsListModel * _Nonnull newsModel) {
            [weakSelf skipToNewsWithModel:newsModel];
        };
        _headerView.mapViewSelectedBlock = ^(NSInteger index) {
             [weakSelf p_skipToDetailControllerWithIndex:index];
         
        };
        
        _headerView.indexSelectedBlock = ^(QICIMarkeModel * _Nullable selectedListModel, BOOL isShowList) {
             [weakSelf p_skipToDetailControllerWithIndex:1];
        };
        _headerView.btnSelectedBlock = ^(NSInteger Tag) {
            if (Tag == 10) {
                [weakSelf pushToWebView:@"https://h.wavehk.cn/appIn/newCollege/?language=zh-cn" titleString:@"新手课堂"];
            }else if (Tag == 11 ){
                [weakSelf pushToWebView:@"https://activity.gkoudai.com/s/2018/tradingRules/index.html" titleString:@"交易规则"];
            }else{
                
            }
        };
    }
    return _headerView;
}
- (void)showIndexList {
    // 展示指数列表
    QICIIndexListViewController *indexListVC = [[QICIIndexListViewController alloc] init];
    indexListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:indexListVC animated:YES];
}

/* 指数详情 */
- (void)p_skipToIndexDetailWithListModel:(QICIMarkeModel *)marketListModel {
    
//    QICIMarketDetailViewController *detailVC = [[QICIMarketDetailViewController alloc] initWithMarketListModel:marketListModel];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)pushToWebView:(NSString *)urlString titleString:(NSString *)titleString{
    QICIBaseWebViewController *fastNewsVC = [[QICIBaseWebViewController alloc] initWithUrl:urlString];
    fastNewsVC.hidesBottomBarWhenPushed = YES;
    fastNewsVC.title = titleString;
    fastNewsVC.webView.scrollView.bounces = NO;
    [self.navigationController pushViewController:fastNewsVC animated:YES];
}
- (void)p_skipToDetailControllerWithIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
        {
            TheMarktAllFuturesViewController *tmafVC = [[TheMarktAllFuturesViewController alloc] init];
            tmafVC.type = TheMarktAllFuturesViewTypeDomestic;
            tmafVC.title = @"国内期货";
            tmafVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tmafVC animated:YES];
            }
            break;
            
        case 1:
        {
            
            TheMarktAllFuturesViewController *tmafVC = [[TheMarktAllFuturesViewController alloc] init];
            tmafVC.type = TheMarktAllFuturesViewTypeForegin;
            tmafVC.title = @"国际期货";
            tmafVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tmafVC animated:YES];
            
        }
            break;
        case 2:
        {
            QICIIndexListViewController *indexVC = [[QICIIndexListViewController alloc] init];
            indexVC.hidesBottomBarWhenPushed = YES;
            indexVC.title = @"股指期货";
            [self.navigationController pushViewController:indexVC animated:YES];
            
        }
            break;
        case 3:
        {
            ASDNewsListViewController *newsListVC = [[ASDNewsListViewController alloc] initWithNeedBackBtn:YES];
            newsListVC.hidesBottomBarWhenPushed = YES;
            newsListVC.title = @"资讯";
            [self.navigationController pushViewController:newsListVC animated:YES];
        }
            break;
        case 4:
        {
            QICIBaseWebViewController *fastNewsVC = [[QICIBaseWebViewController alloc] initWithUrl:@"https://m.fxinz.com/zh/news.html?app=gts2_app_orig&consulting=1&deviceId=&version=100&terminal=ios"];
            fastNewsVC.hidesBottomBarWhenPushed = YES;
            fastNewsVC.title = @"快讯";
            fastNewsVC.webView.scrollView.bounces = NO;
            [self.navigationController pushViewController:fastNewsVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)skipToNewsWithModel:(QCNewsListModel *)newsModel {
    
    QCNewsViewController *newsVC = [[QCNewsViewController alloc] initWithNewsId:newsModel.newsId];
    newsVC.title = newsModel.title;
    
    newsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsVC animated:YES];
}
@end
