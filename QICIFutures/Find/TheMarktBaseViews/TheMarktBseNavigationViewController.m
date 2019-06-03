//
//  TheMarktBseNavigationViewController.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktBseNavigationViewController.h"



@interface TheMarktBseNavigationViewController ()

@end

@implementation TheMarktBseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImage *image = [TheMarktTools createImageWithColor:MarktGlobalColor size:CGSizeMake(SCREEN_WIDTH, kDeviceNavHeight)];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName:[UIColor whiteColor],
                                               NSFontAttributeName:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]};
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}

@end
