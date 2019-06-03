//
//  TheMarktMyAttentionViewController.m
//  QICIFutures
//
//  Created by mac on 2019/6/3.
//

#import "TheMarktMyAttentionViewController.h"
#import "AllFuturesListTableViewCell.h"
#import "TheMarktFuturesInfoViewController.h"
#import "noDataView.h"

@interface TheMarktMyAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) noDataView *noDataView;

@end

@implementation TheMarktMyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}

#pragma - mark 懒加载
-(UITableView *)listView{
    
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kDeviceNavHeight-IS_IPHONE_X*24) style:UITableViewStyleGrouped];
        [_listView registerClass:NSClassFromString(@"AllFuturesListTableViewCell.h") forCellReuseIdentifier:@"AllFuturesListTableViewCell"];
        _listView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(noDataView *)noDataView{
    
    if (!_noDataView) {
        _noDataView = [[noDataView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 180, 100, 130)];
    }
    return _noDataView;
}

#pragma - mark UI
-(void)configUI{
    
    self.title = @"我的关注";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listView];
    
    [self configData];
}

#pragma - mark 数据处理
-(void)configData{
    
    if ([SaveAndUseFuturesDataModel getMyLikelist].count > 0) {
        if ([TheMarktTools internetStatus]) {
            
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[SaveAndUseFuturesDataModel getMyLikelist]];
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        }
        
    }else{
        [self.dataArray removeAllObjects];
        
        if ([TheMarktTools internetStatus]) {
            SVPShowInfo(1, @"暂无关注", ^{
                [self.view addSubview:self.noDataView];
            });
            
            [self.listView removeFromSuperview];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        }
        
    }
    
    if (self.dataArray.count > 0) {
        [self requestInfos];
    }
    
}

#pragma - mark 网络请求
-(void)requestInfos{
    
    [self.listView reloadData];
}

#pragma - mark tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AllFuturesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllFuturesListTableViewCell"];
    if (!cell) {
        cell = [[AllFuturesListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllFuturesListTableViewCell"];
    }
    
    [cell buildWithInfo:self.dataArray[indexPath.row]];
    
    if(indexPath.row < 15){
        
        [cell requestInfos];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TheMarktFuturesInfoViewController *vc = [[TheMarktFuturesInfoViewController alloc] init];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    vc.infoKey = dic.allKeys.firstObject;
    
    weakSelf(self);
    
    vc.isRefreshListView = ^(BOOL isDo) {
        if (isDo) {
            [weakSelf configData];
        }
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (decelerate) {
        NSArray *arr = self.listView.visibleCells;
        for (AllFuturesListTableViewCell *cell in arr) {
            [cell requestInfos];
        }
    }
}

@end
