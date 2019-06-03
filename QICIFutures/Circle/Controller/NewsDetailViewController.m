#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic,strong) UIView *webV;
@property (nonatomic,strong) UIButton *rightBtn;
@end


@implementation NewsDetailViewController

- (UIView *)webV{
    if(!_webV){
        _webV = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kDeviceNavHeight)];
        _webV.backgroundColor = [UIColor redColor];
        
    }
    return _webV;
}

- (UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"newsid"] containsObject:self.dataArr]) {
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_sel"] forState:UIControlStateNormal];
    }else{
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_nor"] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleSting = @"新闻详情";
    self.isHiddenShadow = NO;
    self.isHiddenBackButton = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.opaque = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kDeviceNavHeight);
        make.left.and.right.and.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view);
        }
    }];
    [self requestData];
    [self configRightBtn];
    
}

- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"http://sjzqbj.csc108.com:9800//api/news20/detail/?id=%@&type=L295",self.newsid];
    
    [[YNWHttpRequest sharedInstance]GETRequestWithUrl:str paramaters:nil successBlock:^(id object, NSURLResponse *response) {
        NSString *strHtml = [NSString stringWithFormat:@"<html> \n"
                             "<head> \n"
                             "<style type=\"text/css\"> \n"
                             "body {style=\"background-color: transparent\" font-size:15px;}\n"
                             "p.art_p{fontSize:19px;}\n"
                             "</style> \n"
                             "</head> \n"
                             "<body>"
                             "<script type='text/javascript'>"
                             "window.onload = function(){\n"
                             "var $img = document.getElementsByTagName('img');\n"
                             "for(var p in  $img){\n"
                             " $img[p].style.width = '100%%';\n"
                             "$img[p].style.height ='auto'\n"
                             "}\n"
                             "}"
                             "</script>%@"
                             "</body>"
                             "</html>",object[@"news"][@"body"]];
        [weakSelf.webView loadHTMLString:strHtml baseURL:nil];
    } FailBlock:^(NSError *error) {
        
    }];
    
}

- (void)configRightBtn{
    self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-46, kDeviceStatusHeight+7, 30, 30)];
    [self.rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_nor"] forState:UIControlStateNormal];
    [self.view addSubview:self.rightBtn];
}

- (void)clickRightBtn:(UIButton *)sender{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"newsid"] containsObject:self.dataArr]) {
        NSMutableArray *likeArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"newsid"] mutableCopy];
        [likeArray removeObject:self.dataArr];
        [[NSUserDefaults standardUserDefaults]setObject:likeArray forKey:@"newsid"];
        [sender setBackgroundImage:[UIImage imageNamed:@"shoucang_nor"] forState:UIControlStateNormal];
        [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
        [SVProgressHUD dismissWithDelay:1.f];
    }
    else{
        NSMutableArray *likeArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"newsid"] mutableCopy];
        if (!likeArray) {
            likeArray = [[NSMutableArray alloc]initWithCapacity:0];
        }
        [likeArray addObject:self.dataArr];
        
        NSArray *saveArray = [NSArray arrayWithArray:likeArray];
        [[NSUserDefaults standardUserDefaults]setObject:saveArray forKey:@"newsid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [sender setBackgroundImage:[UIImage imageNamed:@"shoucang_sel"] forState:UIControlStateNormal];
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        [SVProgressHUD dismissWithDelay:1.f];
    }
}

@end
