//
//  FindViewController.m
//  LiveOfBeiJing
//
//  Created by Bingo on 2018/11/30.
//

#import "FindViewController.h"
#import "TheMarktRequestViewModel.h"
#import "TheMarktViewsViewModel.h"
#import "LearnWebViewController.h"

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TheMarktRequestViewModel *requestViewModel;

@property (nonatomic,strong) TheMarktViewsViewModel *viewsViewModel;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation FindViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"");
    
    [self requestAndSaveDatas];
    [self configUI];
}

#pragma - mark 懒加载

-(TheMarktRequestViewModel *)requestViewModel{
    
    if (!_requestViewModel) {
        _requestViewModel = [[TheMarktRequestViewModel alloc] init];
    }
    return _requestViewModel;
}

-(TheMarktViewsViewModel *)viewsViewModel{
    
    if (!_viewsViewModel) {
        _viewsViewModel = [[TheMarktViewsViewModel alloc] init];
        weakSelf(weakSelf);
        _viewsViewModel.jumpToLearnView = ^{
            [weakSelf jumpToLearnView];
        };
        _viewsViewModel.othersBlock = ^(NSInteger index) {
            [weakSelf jumpToOtherView:index];
        };
    }
    return _viewsViewModel;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kDeviceNavHeight-kDeviceTabBarHeight-IS_IPHONE_X*24) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:NSClassFromString(@"TheMarktScrollNewsTableViewCell") forCellReuseIdentifier:@"TheMarktScrollNewsTableViewCell"];
        [_tableView registerClass:NSClassFromString(@"TheMarktLearnsTableViewCell.h") forCellReuseIdentifier:@"TheMarktLearnsTableViewCell.h"];
        [_tableView registerClass:NSClassFromString(@"TheMarktOthersTableViewCell") forCellReuseIdentifier:@"TheMarktOthersTableViewCell.h"];
        [_tableView registerClass:NSClassFromString(@"TheMarktLookFuturesCell") forCellReuseIdentifier:@"TheMarktLookFuturesCell"];
    }
    return _tableView;
}

#pragma - mark 数据

-(void)requestAndSaveDatas{
    
    if ([[SaveAndUseFuturesDataModel getAllDomesticFuturesInfo] isEqualToArray:@[]]) {
        [SVProgressHUD show];
        [self.requestViewModel requestAllFuturesNameInfoSuccess:^{
            [SVProgressHUD dismiss];
        } failture:^(NSString * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }];
    }
    
    if ([[SaveAndUseFuturesDataModel getAllDomesticVegetableOilFuturesInfo] isEqualToArray:@[]]) {
        
        [self.requestViewModel requestAllFuturesVOilNameInfoSuccess:^{
            
        } failture:^(NSString * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }];
    }
    
    if ([[SaveAndUseFuturesDataModel getAllForeignGoodsFuturesInfo] isEqualToDictionary:@{}]) {
        [SaveAndUseFuturesDataModel saveAllForeignGoodsFuturesInfo];
    }
    
    if ([[SaveAndUseFuturesDataModel getAllForeignStockIndexFuturesInfo] isEqualToArray:@[]]) {
        [SaveAndUseFuturesDataModel saveAllForeignStockIndexFuturesInfo];
    }
    
    if ([[SaveAndUseFuturesDataModel getAllForeigncCurrencyFuturesInfo] isEqualToArray:@[]]) {
        [SaveAndUseFuturesDataModel saveAllForeigncCurrencyFuturesInfo];
    }
    
}

#pragma - mark UI

-(void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma - mark tableviewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [self.viewsViewModel tableView:tableView heightForHeaderInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return [self.viewsViewModel tableView:tableView heightForFooterInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.viewsViewModel tableView:tableView heightForRowAtIndexPath:indexPath];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self.viewsViewModel tableView:tableView viewForHeaderInSection:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [self.viewsViewModel tableView:tableView viewForFooterInSection:section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.viewsViewModel numberOfSectionsInTableView:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewsViewModel tableView:tableView numberOfRowsInSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.viewsViewModel tableView:tableView cellForRowAtIndexPath:indexPath];;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.viewsViewModel tableView:tableView didSelectRowAtIndexPath:indexPath viewController:self];
}

#pragma - mark 页面跳转
-(void)jumpToLearnView{
    
    LearnWebViewController *vc = [[LearnWebViewController alloc] init];
    
    vc.urlStr = @"https://m.fxinz.com/app/learner-school.html?app=gts2_app&consulting=1&deviceId=&version=100&terminal=ios";
    vc.title = @"新人讲堂";
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)jumpToOtherView:(NSInteger)index{
    
    LearnWebViewController *vc = [[LearnWebViewController alloc] init];
    
    if (index == 1) {
        vc.urlStr = @"https://activity.gkoudai.com/s/2018/tradingRules/index.html";
        vc.title = @"交易规则";
    }else{
        vc.urlStr = @"http://cj.jidiwangluo.com/EconomicCalendar/eCalendar/pbres/1028/eCalendar/#/";
        vc.title = @"财经日历";
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
