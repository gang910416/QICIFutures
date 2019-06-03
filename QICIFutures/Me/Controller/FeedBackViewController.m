#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeHolderLabel;
@property (nonatomic,strong)UIButton *presentBtn;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleSting = @"意见反馈";
    self.isHiddenBackButton = NO;
    [self createUI];
}

-(void)createUI{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceStatusHeight+44, self.view.frame.size.width, self.view.frame.size.height)];
    bgView.backgroundColor = LineColor;
    
    //先创建个方便多行输入的textView
    self.textView =[ [UITextView alloc]initWithFrame:CGRectMake(0,40,self.view.frame.size.width, 200)];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor whiteColor];
//    self.textView.layer.borderWidth = 1.0;
//    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.font = [UIFont systemFontOfSize:16];
    
    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,-10,290,60)];
    self.placeHolderLabel.numberOfLines = 0;
    self.placeHolderLabel.text = @"请输入您的宝贵意见";
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    
    [bgView addSubview:self.textView];
    [self.textView addSubview:self.placeHolderLabel];
    [self.view addSubview:bgView];
    
    self.presentBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-400,self.view.frame.size.width-40,50)];
    self.presentBtn.backgroundColor = RGBColor(235, 85, 75);
    [self.presentBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.presentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.presentBtn addTarget:self action:@selector(ClickPresentBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.presentBtn.layer.cornerRadius = 8.f;
    self.presentBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.presentBtn];
}

#pragma mark ------UITextViewDelegate------
-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length]==0) {
        self.placeHolderLabel.text = @"请输入您的宝贵意见";
    }else{
        self.placeHolderLabel.text = nil;
    }
}

- (void)ClickPresentBtn:(UIButton *)sender{
    if (self.textView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"提交失败，意见不能为空"];
        [SVProgressHUD dismissWithDelay:1.0];
        self.placeHolderLabel.text = @"请输入您的宝贵意见";
    }else{
        self.hidesBottomBarWhenPushed = YES;
        
        [SVProgressHUD showWithStatus:@"正在提交..."];
        [self performSelector:@selector(delayqingliMethod1) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        
    }
}

- (void)delayqingliMethod1{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
