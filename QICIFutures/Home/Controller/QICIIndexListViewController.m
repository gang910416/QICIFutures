//
//  ASDIndexListViewController.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/23.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "QICIIndexListViewController.h"


#import "QICIMarketListSectionHeaderView.h"

#import "QICIMarkeModel.h"
@interface QICIIndexListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView *listView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIButton *noDataBtn;

@end

static NSString *const ASDIndexListViewCell_id_1 = @"ASDIndexListViewCell_id_1";
@implementation QICIIndexListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self viewDid_adf:@(arc4random() % 100)  num:@(10) arg:@"asd"];

    UIImage * img = [UIImage imageNamed:@"icon_ASD_5"];
    
    if(img) {
        self.view.alpha = 1.0f;
    }
    
    self.isHiddenShadow = NO;
    self.isHiddenBar = NO;
    self.isHiddenBackButton = NO;
    self.navTitleSting = @"指数列表";
    self.view.backgroundColor = QICIColorMarketDetail;

    [self p_asd_configUI];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self p_loadDataFromNet];
}

- (void)p_asd_configUI {
    
    [self.view addSubview:self.listView];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(Nav_topH);
        make.bottom.equalTo(self.view.mas_bottom).offset(- TabMustAdd);
    }];
}

- (void)p_loadDataFromNet {
    weakSelf(self)
    
    [SVProgressHUD show];
    [QCHomeDataMannger getMarketIndexWithBlockSuccess:^(NSArray<QCNewsListModel *> * _Nonnull list) {
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.dataSource removeAllObjects];
        [weakSelf.dataSource addObjectsFromArray:list];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.listView reloadData];
            [weakSelf p_updateNoDataBtnState];
        });
        [SVProgressHUD dismiss];
    } faild:^(NSError * _Nonnull error) {
        [weakSelf.listView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:NetErrorTipString];
        [weakSelf p_updateNoDataBtnState];
    }];
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
    [self p_loadDataFromNet];
    
}

#pragma mark - tableiview delegate ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MArketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ASDIndexListViewCell_id_1 forIndexPath:indexPath];
    QCNewsDetailModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell updataWithMarketModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCALE_Length(60.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QCNewsListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if (model) {
        
//        QICIMarketDetailViewController *detailVC = [[QICIMarketDetailViewController alloc] initWithMarketListModel:model];
//        detailVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return SCALE_Length(40.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[QICIMarketListSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(40.0f)) titles:@[@"股指期货",@"价格",@"涨跌幅"]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
#pragma mark - 懒加载 --

- (UITableView *)listView {
    
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _listView.backgroundColor = [UIColor clearColor];
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.mj_header = [GLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromNetWork)];
        [_listView registerClass:[MArketTableViewCell class] forCellReuseIdentifier:ASDIndexListViewCell_id_1];
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

@end
