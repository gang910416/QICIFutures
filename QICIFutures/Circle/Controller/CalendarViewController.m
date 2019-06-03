#import "CalendarViewController.h"

@interface CalendarViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *myWebView;
@end

@implementation CalendarViewController
- (void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD show];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)createWebView{
    self.myWebView = [[UIWebView alloc]init];
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];
    
    [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(self.view);
    }];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (void)requestData{
    NSURLRequest *requst = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://mbd-mbd.geekthings.com.cn/calender.html"]]];
    [self.myWebView loadRequest:requst];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
