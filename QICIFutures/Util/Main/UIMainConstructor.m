//
//  UMUIConstructor.m
//  youmei
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 um. All rights reserved.
//

#import "UIMainConstructor.h"
#import "QICHomeViewController.h"
#import "FindViewController.h"
#import "CircleViewController.h"
#import "AddViewController.h"
#import "MeViewController.h"
static const NSArray *imageNames;
static const NSArray *selectedImageNames;
static UIMainConstructor *constructor;

@interface UIMainConstructor ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabBarController;

//@property (nonatomic, assign) BOOL isShowBar;
@end

@implementation UIMainConstructor


+ (instancetype)sharedUIConstructor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        constructor = [[UIMainConstructor alloc] init];
        
        
    });
    return constructor;
}


- (instancetype)init
{
    if (self = [super init])
    {
        if (!imageNames) {
            imageNames = @[@"tabbar_home_nor",
                           @"tabbar_market_nor",
                          
                           @"tabbar_fine_nor",
                           @"tabbar_me_nor"
                           ];
        }
        
        if (!selectedImageNames) {
            selectedImageNames = @[@"tabbar_home_sel",
                                   @"tabbar_market_sel",
                                  
                                   @"tabbar_fine_sel",
                                   @"tabbar_me_sel"
                                   ];
        }
        
      
    }
    return self;
}



- (UITabBarController *)constructUI
{
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
//        [UIApplication sharedApplication].keyWindow.rootViewController = self.rootNavigationController;
    [self setupViewControllers];
 
    return self.tabBarController;
}

//设置UI层次结构
- (void)setupViewControllers
{
    // 主页
    QICHomeViewController *homeVc = [[QICHomeViewController alloc] init];

    homeVc.title = @"主页";
    homeVc.hidesBottomBarWhenPushed = NO;
    UINavigationController *homeNC = [[UINavigationController alloc] initWithRootViewController:homeVc];
    
    //发现
    FindViewController *findVc = [[FindViewController alloc] init];
    findVc.title = @"行情";
    findVc.hidesBottomBarWhenPushed =NO;
    TheMarktBseNavigationViewController *findNC = [[TheMarktBseNavigationViewController alloc] initWithRootViewController:findVc];
    

    
    //社区
    CircleViewController *CircleVc = [[CircleViewController alloc] init];
    CircleVc.title = @"资讯";
    CircleVc.hidesBottomBarWhenPushed =NO;
    UINavigationController *circleNC = [[UINavigationController alloc] initWithRootViewController:CircleVc];
    
    //我的
    MeViewController *meVc = [[MeViewController alloc] init];
    meVc.title = @"我的";
    meVc.hidesBottomBarWhenPushed =NO;
    UINavigationController *meNC = [[UINavigationController alloc] initWithRootViewController:meVc];
    

    
    self.tabBarController.viewControllers = @[
                                              homeNC,
                                              findNC,
                                              circleNC,
                                              meNC
                                             ];

    
    [self.tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        UIImage *image = [UIImage imageNamed:imageNames[idx]];
        UIImage *imageSelected = [UIImage imageNamed:selectedImageNames[idx]];
        item.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
    
    self.tabBarController.tabBar.backgroundColor = HexColor(0xFFFFFF);
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(0x666666),
                                                        NSFontAttributeName:[UIFont fontWithName:fFont size:10.f]
                                                        } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(0x000000)} forState:UIControlStateSelected];
    [UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0, -2.0f);
}


@end
