//
//  ASDSearchListViewController.m
// ASDFutureProject
//
//  Created by 幽雅的暴君 on 2019/4/19.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "QCSearchListViewController.h"
#import "QCMarketListSectionHeaderView.h"
#import "QCMarketListCell.h"

@interface QCSearchListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@end

static NSString *const ASDSearchListViewCell_id_1 = @"ASDSearchListViewCell_id_1";

@implementation QCSearchListViewController
- (instancetype)initWithSearchList:(NSArray * _Nullable)list {
    
    if (self = [super init]) {
        
        if (list && list.count > 0) {
            [self.dataSource addObjectsFromArray:list];
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self viewDid_adf:@(arc4random() % 100)  num:@(10) arg:@"asd"];
    
    UIImage * img = [UIImage imageNamed:@"icon_ASD_12"];
    
    if(img) {
        self.view.alpha = 1.0f;
    }

    self.isHiddenTitleView = NO;
    self.isHiddenBackButton = NO;
    self.navTitleSting = @"搜索结果";
    self.view.backgroundColor = QICIColorMarketDetail;
    
    [self p_asd_configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.listView reloadData];
}


- (void)p_asd_configUI {
    
    [self.view addSubview:self.listView];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(Nav_topH);
        make.height.mas_equalTo(kDeviceHeight - Tab_H - Nav_topH);
    }];
    
}

#pragma mark - tableiview delegate ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCMarketListCell *cell = [tableView dequeueReusableCellWithIdentifier:ASDSearchListViewCell_id_1 forIndexPath:indexPath];
    ASDMarketListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateWithDataModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCALE_Length(60.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ASDMarketListModel *model = [self.dataSource objectAtIndex:indexPath.row];
//    
//    ASDMarketDetailViewController *detailVC = [[ASDMarketDetailViewController alloc] initWithMarketListModel:model];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0.001;
    if (section == 0) {
        height = SCALE_Length(40.0f);
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(40.0f))];
        secView.backgroundColor = QICIColorGap;
        [secView addSubview:[[QCMarketListSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, SCALE_Length(40.0f)) titles:@[@"期货",@"最新价",@"涨跌幅"]]];
        
        return secView;
    }else {
        return nil;
    }
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
        _listView.backgroundColor = [UIColor clearColor];
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.delegate = self;
        _listView.dataSource = self;
        [_listView registerClass:[QCMarketListCell class] forCellReuseIdentifier:ASDSearchListViewCell_id_1];
    }
    return _listView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

@end
