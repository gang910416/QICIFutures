//
//  TheMarktAllFuturesViewController.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktAllFuturesViewController.h"
#import "TheMarktAllDomesticView.h"
#import "TheMarktAllForeginView.h"
#import "TheMarktFuturesInfoViewController.h"

@interface TheMarktAllFuturesViewController ()

@property (nonatomic,strong) TheMarktAllDomesticView *domesticView;

@property (nonatomic,strong) TheMarktAllForeginView *foreginView;

@end

@implementation TheMarktAllFuturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}

-(void)configUI{
    
    if (self.type == TheMarktAllFuturesViewTypeDomestic) {
        [self.view addSubview:self.domesticView];
    }else{
        [self.view addSubview:self.foreginView];
    }
}

#pragma - mark 懒加载

-(TheMarktAllDomesticView *)domesticView{
    
    if (!_domesticView) {
        _domesticView = [[TheMarktAllDomesticView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT-kDeviceNavHeight-IS_IPHONE_X*24)];
        weakSelf(weakSelf);
        _domesticView.selectRowBlock = ^(NSDictionary * _Nonnull dic) {
            [weakSelf selectRowWithType:@"7" andInfo:dic];
        };
    }
    return _domesticView;
}

-(TheMarktAllForeginView *)foreginView{
    
    if (!_foreginView) {
        _foreginView = [[TheMarktAllForeginView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT-kDeviceNavHeight-IS_IPHONE_X*24)];
        weakSelf(weakSelf);
        _foreginView.selectRowBlock = ^(NSDictionary * _Nonnull dic) {
            [weakSelf selectRowWithType:@"2" andInfo:dic];
        };
    }
    return _foreginView;
}

-(void)selectRowWithType:(NSString *)type andInfo:(NSDictionary *)dic{
    
    TheMarktFuturesInfoViewController *vc = [[TheMarktFuturesInfoViewController alloc] init];
    
    if ([type isEqualToString:@"7"]) {
        
        vc.infoKey = dic[@"symbol"];
    }else{
        
        vc.infoKey = dic.allKeys.firstObject;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
