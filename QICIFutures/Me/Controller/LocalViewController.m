
//
//  LocalViewController.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "LocalViewController.h"

@interface LocalViewController ()
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation LocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenBackButton = NO;
    self.navTitleSting = self.titleStr;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kDeviceStatusHeight+44, kDeviceWidth, kDeviceHeight-(kDeviceStatusHeight+44))];
    self.webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.localStr]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}


@end
