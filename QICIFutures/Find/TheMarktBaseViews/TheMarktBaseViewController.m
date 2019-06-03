//
//  TheMarktBaseViewController.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktBaseViewController.h"

@interface TheMarktBaseViewController ()

@end

@implementation TheMarktBaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"\n[--------------------当前页面为:%@------------------]\n",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn setImage:imageWithName(@"bt_navigation_white_nor") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }else if([self.presentingViewController isKindOfClass:NSClassFromString(@"UITabBarController")]){
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn setImage:imageWithName(@"bt_navigation_white_nor") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(preBackClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}

-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)preBackClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
