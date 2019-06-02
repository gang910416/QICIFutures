//
//  TheMarktFuturesInfoViewController.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktFuturesInfoViewController.h"
#import "FuturesKModel.h"
#import "SearchIResultDataTableViewCell.h"
#import "SearchResultchartsTableViewCell.h"
#import "TheMarktFuturesNewsTableViewCell.h"
#import "TheMarktNewsModel.h"
#import "TheMarktRequestNewsModel.h"
#import "LearnWebViewController.h"

@interface TheMarktFuturesInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *domisticTypeArray;
}

@property (nonatomic,assign) BOOL isChangeAttentionStatus;

@property (nonatomic,strong) UITableView *listView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) BOOL isGuonei;

@property (nonatomic,strong) NSMutableArray *otherInfos;

@property (nonatomic,strong) NSMutableArray *newsArray;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) TheMarktRequestNewsModel *newsViewModel;

@end

@implementation TheMarktFuturesInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    domisticTypeArray = @[@"7",@"2",@"3",@"4",@"5"];
    self.isGuonei = [SaveAndUseFuturesDataModel getCodeIsDomestic:self.infoKey];
    
    [self configUI];
    
    [self requestData];
}

#pragma - mark 懒加载

-(TheMarktRequestNewsModel *)newsViewModel{
    if (!_newsViewModel) {
        _newsViewModel = [[TheMarktRequestNewsModel alloc] init];
    }
    return _newsViewModel;
}

-(NSMutableArray *)newsArray{
    
    if (!_newsArray) {
        _newsArray = [NSMutableArray array];
    }
    return _newsArray;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)otherInfos{
    
    if (!_otherInfos) {
        _otherInfos = [NSMutableArray array];
    }
    return _otherInfos;
}

-(UITableView *)listView{
    
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kDeviceNavHeight-IS_IPHONE_X*24) style:UITableViewStyleGrouped];
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.backgroundColor = [UIColor whiteColor];
//        _listView.rowHeight = UITableViewAutomaticDimension;
//        _listView.estimatedRowHeight = 200;
        [_listView registerClass:NSClassFromString(@"SearchIResultDataTableViewCell") forCellReuseIdentifier:@"SearchIResultDataTableViewCell"];
        [_listView registerClass:NSClassFromString(@"SearchResultchartsTableViewCell") forCellReuseIdentifier:@"SearchResultchartsTableViewCell"];
        [_listView registerClass:NSClassFromString(@"TheMarktFuturesNewsTableViewCell") forCellReuseIdentifier:@"TheMarktFuturesNewsTableViewCell"];
        
    }
    return _listView;
}

#pragma - mark UI

-(void)configUI{
    
    self.view.backgroundColor = TheMarktFuturesColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    [btn setImage:imageWithString(@"bottom_collect_sel") forState:UIControlStateSelected];
//    [btn setImage:imageWithString(@"bottom_collect_nor") forState:UIControlStateNormal];
    btn.selected = [SaveAndUseFuturesDataModel isLikeFutures:self.infoKey.uppercaseString];
    
    [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(-20, 0, 30, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.listView];
}

#pragma - mark 网络请求
-(void)requestData{
    
    [SVProgressHUD show];
    
    NSDictionary *param = @{@"code":self.isGuonei?self.infoKey:[NSString stringWithFormat:@"hf_%@",self.infoKey.uppercaseString],@"token":tokenKey};
    
    [[HttpRequest sharedInstance] oneGet:@"" path:@"http://data.api51.cn/apis/multi_real/" parameters:param success:^(id responsData) {
        [SVProgressHUD dismiss];
        NSArray *arr = [self finishingData:responsData];
        if (arr.count > 0) {
            NSArray *tempArr = arr.firstObject;
            if (tempArr.count > 0) {
                
                [self.otherInfos removeAllObjects];
                [self.otherInfos addObjectsFromArray:tempArr];
                [self.listView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:NO];
            }else{
                
            }
            
        }else{
            
        }
        
    } faile:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD dismissWithDelay:1];
    }];
    
    if (self.isGuonei) {
        [self requestKlineData:@"7" isGuonei:YES];
    }else{
        [self requestKlineData:@"2" isGuonei:NO];
    }
    
    weakSelf(weakSelf);
    [self.newsViewModel requestFuturesNewsInfoSuccess:^(NSArray * _Nonnull dataArray) {
        [weakSelf.newsArray addObjectsFromArray:dataArray];
//        [weakSelf.listView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.listView reloadData];
    } failture:^(NSString * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error];
        [SVProgressHUD dismissWithDelay:1];
    } timeout:^{
        [SVProgressHUD showErrorWithStatus:@"超时"];
        [SVProgressHUD dismissWithDelay:1];
    }];
}

-(void)requestKlineData:(NSString *)type isGuonei:(BOOL)isGuonei{
    
    [SVProgressHUD show];
    
    if (isGuonei) {
        NSDictionary *param = @{@"future_code":self.infoKey,@"type":type,@"token":tokenKey};
        
        [SVProgressHUD show];
        [[HttpRequest sharedInstance] oneGet:@"" path:@"http://data.api51.cn/apis/futures/chart/" parameters:param success:^(id responsData) {
            
            [SVProgressHUD dismiss];
            
            NSArray *arr = [self configDataArray:responsData type:@"guonei"];
            
            if (arr.count > 0) {
                
                [self.dataArray removeAllObjects];
                for (FuturesKModel *model in arr) {
                    NSDictionary *dic = [model mj_keyValues];
                    [self.dataArray addObject:dic];
                }
                
                [self.listView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:NO];
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败!"];
                [SVProgressHUD dismissWithDelay:1];
            }
            
        } faile:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"请求超时!"];
            [SVProgressHUD dismissWithDelay:1];
        }];
    }else{
        NSDictionary *param = @{@"future_code":self.infoKey,@"type":type,@"token":tokenKey};
        
        [SVProgressHUD show];
        [[HttpRequest sharedInstance] oneGet:@"" path:@"http://data.api51.cn/apis/usfutures/chart/" parameters:param success:^(id responsData) {
            [SVProgressHUD dismiss];
            NSArray *arr = [self configDataArray:responsData type:@"guowai"];
            
            if (arr.count > 0) {
                [self.dataArray removeAllObjects];
                for (FuturesKModel *model in arr) {
                    NSDictionary *dic = [model mj_keyValues];
                    [self.dataArray addObject:dic];
                }
                
                [self.listView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:NO];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败!"];
                [SVProgressHUD dismissWithDelay:1];
            }
            
        } faile:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"请求超时!"];
            [SVProgressHUD dismissWithDelay:1];
        }];
    }
    
}

-(void)rightBtnClick:(UIButton *)btn{
    
    if ([TheMarktTools internetStatus]) {
        weakSelf(weakSelf);
        
        void (^block)(void) = ^{
            
            weakSelf.isChangeAttentionStatus = YES;
            
            if (btn.selected) {
                [SaveAndUseFuturesDataModel removeLikeFutures:weakSelf.infoKey.uppercaseString];
            }else{
                [SaveAndUseFuturesDataModel saveLikeFutures:weakSelf.infoKey.uppercaseString name:weakSelf.title];
            }
            btn.selected = !btn.selected;
        };
        
        SVPShowInfo(1,@"操作成功", block);
    }else{
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:1];
    }
    
}

-(NSArray *)finishingData:(NSData *)data{
    
    NSMutableArray *finalArray = [NSMutableArray array];
    
    NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:data encoding:enc];
    
    NSArray *strArray = [str componentsSeparatedByString:@"\n"];
    
    for (NSString *temp in strArray) {
        NSArray *array = [temp componentsSeparatedByString:@","];
        [finalArray addObject:array];
    }
    
    return finalArray;
}

-(NSArray *)configDataArray:(id )dataArray type:(NSString *)type{
    
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:dataArray options:NSJSONReadingMutableContainers error:&err];
    if (!err) {
        
        if (array.count > 0) {
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                if ([type isEqualToString:@"guonei"]) {
                    FuturesKModel *model = [FuturesKModel mj_objectWithKeyValues:dic];
                    
                    model.low = dic[@"l"];
                    model.open = dic[@"o"];
                    model.high = dic[@"h"];
                    model.volume = dic[@"v"];
                    model.date = dic[@"d"];
                    model.close = dic[@"c"];
                    
                    //                    model.ma5 = dic[@"o"];
                    //                    model.ma10 = dic[@"o"];
                    //                    model.ma20 = dic[@"o"];
                    
                    [temp addObject:model];
                }else{
                    FuturesKModel *model = [FuturesKModel mj_objectWithKeyValues:dic];
                    
                    //                    model.ma5 = dic[@"open"];
                    //                    model.ma10 = dic[@"open"];
                    //                    model.ma20 = dic[@"open"];
                    
                    [temp addObject:model];
                }
            }
            return temp;
        }else{
            return @[];
        }
    }else{
        
        return @[];
    }
}

#pragma - mark tableviewdelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
        {
            return 75;
        }
            break;
        case 1:
        {
            return 340;
        }
            break;
        case 2:
        {
            return 110;
        }
            break;

        default:
            return 0.01;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 2) {
        return self.newsArray.count;
    }else{
        return 1;
    }
//    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:
        {
            SearchIResultDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchIResultDataTableViewCell"];
            if (!cell) {
                cell = [[SearchIResultDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchIResultDataTableViewCell"];
            }
            
            [cell refreshWithDatas:self.otherInfos isGuonei:self.isGuonei];
            
            return cell;
            
        }
            break;
        case 1:
        {
            SearchResultchartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultchartsTableViewCell"];
            if (!cell) {
                cell = [[SearchResultchartsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultchartsTableViewCell"];
            }
            
            BOOL isGuonei = [SaveAndUseFuturesDataModel getCodeIsDomestic:self.infoKey];
            
            [cell refreshWithData:self.dataArray type:isGuonei?@"guonei":@"guowai"];
            
            weakSelf(weakSelf);
            [cell.btnView selectIndex:self.index];
            cell.requestKLineType = ^(NSInteger type) {
                weakSelf.index = type;
                [weakSelf reRequestKlingInfo:type];
            };
            
            return cell;
        }
            break;
        case 2:
        {
            TheMarktFuturesNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheMarktFuturesNewsTableViewCell"];
            if (!cell) {
                cell = [[TheMarktFuturesNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TheMarktFuturesNewsTableViewCell"];
            }
            TheMarktNewsModel *model = self.newsArray[indexPath.row];
            
            [cell buildWihtModel:model];

            return cell;
        }
            break;
            
            
        default:
        {
            return [[UITableViewCell alloc] init];
        }
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        TheMarktNewsModel *model = self.newsArray[indexPath.row];
        LearnWebViewController *vc = [[LearnWebViewController alloc] init];
        vc.urlStr = model.url;
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)reRequestKlingInfo:(NSInteger )type{
    
    BOOL isGuonei = [SaveAndUseFuturesDataModel getCodeIsDomestic:self.infoKey];
    if (isGuonei) {
        NSString *requestType = domisticTypeArray[type];
        [self requestKlineData:requestType isGuonei:YES];
    }else{
        [self requestKlineData:@"2" isGuonei:NO];
    }
}


@end
