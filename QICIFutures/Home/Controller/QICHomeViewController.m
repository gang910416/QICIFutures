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
@interface QICHomeViewController ()<
UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *li_dataArray;
@property (strong, nonatomic) GLRefreshHeader *listRefreshHeader;
@property (strong, nonatomic) UIScrollView *contentView;
/** 搜索按钮  */
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) QCHomeHeaderView *headerView;

/** sectionView */
@property (strong, nonatomic) QICIMarketListSectionHeaderView *sectionView;
@end

static NSString *const homeCellId = @"homeCellId";
@implementation QICHomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self  lg_configUi];
    
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


#pragma mark - tableviewDelegate ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.li_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MArketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellId forIndexPath:indexPath];
    QICIMarkeModel *model = [self.li_dataArray objectAtIndex:indexPath.row];
    [cell updataWithMarketModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCALE_Length(60.0f);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCALE_Length(40.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    QICIMarketListModel *model = self.dataSource[indexPath.row];
//
//    if (model) {
//        QICIMarketDetailViewController *detailVC = [[QICIMarketDetailViewController alloc] initWithMarketListModel:model];
//        detailVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }
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
        [_tableView registerClass:[MArketTableViewCell class] forCellReuseIdentifier:homeCellId];
    }
    return _tableView;
}


- (QCHomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[QCHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(490.0f)+ SCALE_Length(160))];
        weakSelf(self);
//                _headerView.backgroundColor = [UIColor redColor];
        _headerView.newsSelectedBlock = ^(QCNewsListModel * _Nonnull newsModel) {
            [weakSelf skipToNewsWithModel:newsModel];
        };
        _headerView.mapViewSelectedBlock = ^(NSInteger index) {

            [weakSelf p_skipToDetailControllerWithIndex:index];
        };
        
        _headerView.indexSelectedBlock = ^(QICIMarkeModel * _Nullable selectedListModel, BOOL isShowList) {
            if (isShowList) {
                [weakSelf showIndexList];
            }else {
                [weakSelf p_skipToIndexDetailWithListModel:selectedListModel];
            }
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
          
        }
            break;
            
        case 1:
        {
          
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
//            QICINewsListViewController *newsListVC = [[QICINewsListViewController alloc] initWithNeedBackBtn:YES];
//            newsListVC.hidesBottomBarWhenPushed = YES;
//            newsListVC.title = @"资讯";
//            [self.navigationController pushViewController:newsListVC animated:YES];
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
