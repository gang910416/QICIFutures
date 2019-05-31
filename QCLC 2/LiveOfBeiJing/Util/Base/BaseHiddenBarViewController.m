//
//  BaseHiddenBarViewController.m
//  LiveOfBeiJing
//
//  Created by liuyongfei on 2018/11/20.
//

#import "BaseHiddenBarViewController.h"

@interface BaseHiddenBarViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UILabel *navTitle;
//@property (nonatomic, strong) UIView *navTitleView;
@property (nonatomic, strong) UIView *shadowLine;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, assign) BOOL isHidShadow;
@property (nonatomic, assign) BOOL isHidBar;
@property (nonatomic, assign) BOOL isHidTitleView;
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation BaseHiddenBarViewController

- (void)viewWillAppear:(BOOL)animated {
    [  super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self configDefaultValue];
    [self configBaseUi];
    [self configBaseLayout];
}
- (void)configDefaultValue
{
    self.isHidShadow = NO;
    self.isHidBar = NO;
    self.isHidTitleView = YES;
    self.isGesturesBack = YES;
}
- (void)configBaseUi
{
    UIView *navBar = [[UIView alloc]init];
    navBar.hidden = self.isHidBar;
    navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: navBar];
    
    UIView *navTitleView = [[UIView alloc] init];
    navTitleView.hidden = self.isHidTitleView;
    navTitleView.backgroundColor = [UIColor whiteColor];
    [navBar addSubview:navTitleView];
    
    UILabel *navTitle = [[UILabel alloc] init];
    navTitle.font = [UIFont systemFontOfSize:17.f];
    navTitle.textColor = [UIColor blackColor];
    [navBar addSubview:navTitle];
    
    UIView *shadowLine = [[UIView alloc]init];
    shadowLine.hidden = self.isHidShadow;
    shadowLine.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1];
    [navBar addSubview: shadowLine];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.hidden = YES;
    [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"bt_navigation_back_nor"] forState:UIControlStateNormal];
    [backButton setTitle:@"   " forState:UIControlStateNormal];
    [navBar addSubview:backButton];
    
    self.backButton = backButton;
    self.navTitleView = navTitleView;
    self.navTitle = navTitle;
    self.shadowLine = shadowLine;
    self.navBar = navBar;
    
}

- (void)configBaseLayout
{
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kDeviceStatusHeight + 44);
    }];
    
    [self configTitleViewLayout];
    [self configTitleLayout];
    
    [self.shadowLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(self.navBar);
        make.height.mas_equalTo(1);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerY.mas_equalTo(self.navTitleView);
    }];
}
- (void)configTitleViewLayout
{
    [self.navTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(self.navBar);
        make.top.mas_equalTo(self.navBar).mas_offset(kDeviceStatusHeight);
    }];
}
- (void)configTitleLayout
{
    CGFloat y = (44  + kDeviceStatusHeight) / 2 - 22;
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navBar);
        make.centerY.mas_equalTo(y);
    }];
}

- (void)setNavBackGroundColor:(UIColor *)navBackGroundColor
{
    self.navBar.backgroundColor = navBackGroundColor;
}
- (void)setNavTitleSting:(NSString *)navTitleSting
{
    self.navTitle.text = navTitleSting;
    [self configTitleLayout];
    
}

- (void)setNavTitleColor:(UIColor *)navTitleColor
{
    self.navTitle.textColor = navTitleColor;
}
- (void)setNavTitleFont:(UIFont *)navTitleFont
{
    self.navTitle.font = navTitleFont;
}
- (void)setShadowColor:(UIColor *)shadowColor
{
    self.shadowLine.backgroundColor = shadowColor;
}
- (void)setIsHiddenShadow:(BOOL)isHiddenShadow
{
    self.isHidShadow = isHiddenShadow;
    self.shadowLine.hidden = isHiddenShadow;
}

- (void)setIsHiddenTitleView:(BOOL)isHiddenTitleView
{
    self.isHidTitleView = isHiddenTitleView;
    self.navTitleView.hidden = isHiddenTitleView;
}
-(void)setIsHiddenBackButton:(BOOL)isHiddenBackButton
{
    self.backButton.hidden = isHiddenBackButton;
}
-(void)setIsHiddenBar:(BOOL)isHiddenBar
{
    self.isHidBar = isHiddenBar;
    self.navBar.hidden = isHiddenBar;
}

- (void)clickBackButton:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    //判断是否为rootViewController
    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    return self.isGesturesBack;
}  
@end
