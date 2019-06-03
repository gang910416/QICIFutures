//
//  ASDBaseWebViewController.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "QICIBaseWebViewController.h"

@interface QICIBaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (readwrite, strong, nonatomic) NSString *url;

@property (readwrite, strong, nonatomic) NSString *htmlString;

@property (readwrite, strong, nonatomic) WKWebView *webView;

@property (readwrite, strong, nonatomic) WKWebViewConfiguration *wkwebConfig;

@end

@implementation QICIBaseWebViewController


- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        if (!isStrEmpty(url)) {
            self.url = url;
        }
    }
    return self;
}

- (instancetype)initWithHtmlString:(NSString *)htmlString {
    if (self = [super init]) {
        if (!isStrEmpty(htmlString)) {
            self.htmlString = htmlString;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self viewDid_adf:@(arc4random() % 100)  num:@(10) arg:@"asd"];
    
    UIImage * img = [UIImage imageNamed:@"icon_ASD_2"];
    
    if(img) {
        self.view.alpha = 1.0f;
    }
    self.isHiddenBackButton = NO;
    self.isHiddenBar = NO;
    weakSelf(self);
    self.navBackAction = ^BOOL(UIButton * _Nonnull backBtn) {
        BOOL canBack = YES;
        if ([weakSelf.webView canGoBack]) {
            canBack = NO;
            [weakSelf.webView goBack];
        }
        return canBack;
    };
    [self p_asd_configUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self p_loadWebView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    [self.webView stopLoading];
}



- (void)p_asd_configUI {
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(Nav_topH);
        make.bottom.equalTo(self.view.mas_bottom).offset(- TabMustAdd);
    }];
}


- (void)p_loadWebView {
    
    NSURL *url = [NSURL URLWithString:self.url];
    
    if (url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        [SVProgressHUD show];
        return;
    }
    
    if (!isStrEmpty(self.htmlString)) {
        [self.webView loadHTMLString:self.htmlString baseURL:nil];
        
        [SVProgressHUD show];
        return;
    }
}

- (void)updateWithUrl:(NSString *)url {
    
    if (!isStrEmpty(url)) {
        self.url = url;
        
        NSURL *urlObj = [NSURL URLWithString:self.url];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:urlObj]];
    }
}

- (void)updateHtmlString:(NSString *)htmlString {
    if (!isStrEmpty(htmlString)) {
        self.htmlString = htmlString;
    }else {
        self.htmlString = @"";
    }
    
    [self p_loadWebView];
}

- (void)reloadWebView {
    
    [self p_loadWebView];
}

- (void)p_removeElement {
    
    // 2.去掉页面标题
    NSMutableString *str = [NSMutableString string];
    // 3.根据标签类型获取指定标签的元素
    [str appendString:@"var asd = document.getElementById(\"backWashNav\");"];
    [str appendString:@"asd.parentNode.removeChild(asd);"]; // 移除底部
    [self.webView evaluateJavaScript:str completionHandler:nil];
    
    NSMutableString *str2 = @"".mutableCopy;
    [str2 appendString:@"var qer = document.getElementsByClassName(\"equityBackWash\")[0];"];
    [str2 appendString:@"qer.parentNode.removeChild(qer);"]; // 移除底部
    [self.webView evaluateJavaScript:str2 completionHandler:nil];
    
    NSMutableString *str3 = @"".mutableCopy;
    [str3 appendString:@"var uyt = document.getElementsByClassName(\"search-wrap\")[0];"];
    [str3 appendString:@"uyt.parentNode.removeChild(uyt);"]; // 移除搜索框
    [self.webView evaluateJavaScript:str3 completionHandler:nil];
    
    [self.webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background-color='#ffffff'" completionHandler:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.view addSubview:self.webView];
    });
}


#pragma mark - 代理方法<WKNavigationDelegate> --
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    if (!isStrEmpty(webView.title)) {
        self.title = webView.title;
        
        self.navTitleSting = webView.title;
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
    [SVProgressHUD dismiss];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    NSLog(@"%s",__func__);
    if (!isStrEmpty(webView.title)) {
        self.title = webView.title;
        
        self.navTitleSting = webView.title;
    }
    
    [self p_removeElement];
    
    [SVProgressHUD dismiss];
}


// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
        [SVProgressHUD dismiss];
}

// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    NSLog(@"%s",__func__);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if (!isStrEmpty(webView.title)) {
        self.title = webView.title;
        
        self.navTitleSting = webView.title;
    }
    
    if(navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    //这句是必须加上的，不然会异常
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"%s",__func__);
    
}

#pragma mark - js交互代理 --

//显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"弹窗alert,title:%@,frame:%@",message,frame);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil   message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //这里必须执行不然页面会加载不出来
        completionHandler();
    }];
    [alert addAction:a1];
    [self presentViewController:alert animated:YES completion:nil];
}

//弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt message:defaultText preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //这里必须执行不然页面会加载不出来
        completionHandler(@"");
    }];
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler([alert.textFields firstObject].text);
    }];
    [alert addAction:a1];
    [alert addAction:a2];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

//显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    NSLog(@"弹窗确认框");
    NSLog(@"%@",message);
    NSLog(@"%@",frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
/**
 js调OC的代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"name:%@,body:%@",message.name,message.body);
}

#pragma mark - 懒加载 --
- (WKWebView *)webView {
    
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.wkwebConfig];
        _webView.backgroundColor = QICIColorBackGround;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _webView;
}
- (WKWebViewConfiguration *)wkwebConfig {
    
    if (!_wkwebConfig) {
        _wkwebConfig = [[WKWebViewConfiguration alloc] init];
        _wkwebConfig.preferences = [[WKPreferences alloc]init];
        _wkwebConfig.preferences.javaScriptEnabled = YES;
        _wkwebConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        _wkwebConfig.processPool = [[WKProcessPool alloc]init];
        _wkwebConfig.allowsInlineMediaPlayback = YES;
        _wkwebConfig.userContentController = [[WKUserContentController alloc] init];
    }
    return _wkwebConfig;
}
@end
