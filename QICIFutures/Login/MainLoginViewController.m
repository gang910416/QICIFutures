//
//  MainLoginViewController.m
//  QICIFutures
//
//  Created by mac on 2019/5/31.
//

#import "MainLoginViewController.h"

@interface MainLoginViewController ()
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UITextField *loginNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *registerNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *registerPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *registerAgainPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *registerLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation MainLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenBar = YES;
    self.loginView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.loginView];
}
- (IBAction)clickCloseBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)clickLoginBtn:(id)sender {
    NSArray *numberTFArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"numberTFArr"];
    NSArray *codeTFArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"codeTFArr"];
    if ([self.loginNumberTF.text isEqualToString:ACCOUNT] || [numberTFArr containsObject:self.loginNumberTF.text] ) {
        if([self.loginPasswordTF.text isEqualToString:PASSWORD] || [codeTFArr containsObject:self.loginPasswordTF.text] ){
            [[NSUserDefaults standardUserDefaults]setObject:self.loginNumberTF.text forKey:@"loginnumber"];
            [SVProgressHUD showWithStatus:@"正在登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [SVProgressHUD dismiss];
                               [[UserModel getInstance]userLogIn];
                               [self dismissViewControllerAnimated:YES completion:nil];                           });
        }else{
            [SVProgressHUD showErrorWithStatus:@"密码错误"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"账号错误"];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}

- (IBAction)clickLogoutBtn:(id)sender {
    
    if (self.registerNumberTF.text.length >= 11) {
        if (self.registerPasswordTF.text.length >= 6) {
            if ([self.registerPasswordTF.text isEqualToString:self.registerAgainPasswordTF.text]) {
                 [[NSUserDefaults standardUserDefaults]setObject:self.registerNumberTF.text forKey:@"loginnumber"];
                NSMutableArray *numberTFArr = [[[NSUserDefaults standardUserDefaults]objectForKey:@"numberTFArr"] mutableCopy];
                if (!numberTFArr) {
                    numberTFArr = [[NSMutableArray alloc]initWithCapacity:0];
                }
                
                [numberTFArr addObject:self.registerNumberTF.text];
                NSArray *saveArray = [NSArray arrayWithArray:numberTFArr];
                [[NSUserDefaults standardUserDefaults]setObject:saveArray forKey:@"numberTFArr"];
                
                NSMutableArray *codeTFArr = [[[NSUserDefaults standardUserDefaults]objectForKey:@"codeTFArr"] mutableCopy];
                if (!codeTFArr) {
                    codeTFArr = [[NSMutableArray alloc]initWithCapacity:0];
                }
                [codeTFArr addObject:self.registerPasswordTF.text];
                NSArray *saveCodeTFArr = [NSArray arrayWithArray:codeTFArr];
                [[NSUserDefaults standardUserDefaults]setObject:saveCodeTFArr forKey:@"codeTFArr"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [SVProgressHUD showWithStatus:@"正在登录"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                               {
                                   [SVProgressHUD dismiss];
                                   [[UserModel getInstance] userLogIn];
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               });
               
            }else{
                [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
                [SVProgressHUD dismissWithDelay:2.0];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请设置6位以上的密码"];
            [SVProgressHUD dismissWithDelay:2.0];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        [SVProgressHUD dismissWithDelay:2.0];
    }
    
    
    
}


- (IBAction)clickRegsiterForLoginView:(id)sender {
    [self.loginView removeFromSuperview];
    self.registerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.registerView];
}

- (IBAction)clickLoginForRegisterView:(id)sender {
    [self.registerView removeFromSuperview];
    self.loginView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.loginView];
}


@end
