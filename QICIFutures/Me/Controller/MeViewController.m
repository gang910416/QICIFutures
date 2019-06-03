#import "MeViewController.h"
#import "MineHeaderViewCell.h"
#import "MeTableViewCell.h"
#import <StoreKit/StoreKit.h>
#import "CollectionViewController.h"
#import "SelectPhotoManager.h"
#define ScaleHeight SCREEN_HEIGHT / 667
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *meTableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) UIImage *img;
@property (nonatomic, strong)SelectPhotoManager *photoManager;
@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configTableView];
    self.img = [UIImage imageNamed:@"head"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.isHiddenBar = YES;
    
}

- (void)configTableView{
    self.meTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -kDeviceStatusHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kDeviceTabBarHeight+kDeviceStatusHeight) style:UITableViewStyleGrouped];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.showsVerticalScrollIndicator = NO;
    [self.meTableView registerNib:[UINib nibWithNibName:@"MeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeTableViewCell"];
    [self.meTableView registerClass:[MineHeaderViewCell class] forCellReuseIdentifier:@"MineHeaderViewCell"];
    self.meTableView.alwaysBounceVertical = NO;
    self.meTableView.bounces = NO;
    [self.view addSubview:self.meTableView];
}

- (void)getData{
    self.titleArr = @[@{
                          @"title":@[@""]
                          },@{
                              @"title":@[@"给个好评",@"分享App",@"我的收藏"],
                              @"image":@[@"1",@"2",@"3"]
                              },@{
                              @"title":@[@"意见反馈",@"清理缓存",@"关于我们",@"隐私协议",@"联系我们"],
                              @"image":@[@"4",@"5",@"6",@"7",@"8"]
                              },@{
                              @"title":@[@"退出登录"],
                              @"image":@[@"9"]
                              }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([[UserModel getInstance]getUserIsLogin]) {
        return self.titleArr.count;
    }else{
        return self.titleArr.count-1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.titleArr[section] objectForKey:@"title"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MineHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHeaderViewCell"];
        if (!cell) {
            cell = [[MineHeaderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineHeaderViewCell"];
        }
        [cell.header addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpLogin)]];
        if ([[UserModel getInstance]getUserIsLogin]) {
            cell.name.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginnumber"];
            UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
            cell.header.image = img;
            
        }else{
            cell.name.text = @"请注册/登陆";
            cell.header.image = [UIImage imageNamed:@"head"];
        }
        
        
        return cell;
    }else{
        MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell"];
        if (!cell) {
            cell = [[MeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeTableViewCell"];
        }
        cell.titleLab.text = [self.titleArr[indexPath.section] objectForKey:@"title"][indexPath.row];
        cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.titleArr[indexPath.section] objectForKey:@"image"][indexPath.row]]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 210 *ScaleHeight;
    }
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if (indexPath.row == 0) {
            [self gotoCommit];
        }else if (indexPath.row == 1) {
            [self shareApp];
        }else{
            [self myCollection];
        }
    }
    else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            [SVProgressHUD showWithStatus:@"正在退出登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [SVProgressHUD dismiss];
                               [[UserModel getInstance]userLogOut];
                               [self viewWillAppear:YES];
                           });
            
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            [self feedBack];
        }else if(indexPath.row == 1){
            [self cleanSuccess];
        }else if (indexPath.row == 2){
            [self pushToAboutUs];
        }else if(indexPath.row == 3){
            [self service];
        }
        else if (indexPath.row == 4) {
            [self replySuccess];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark 登陆界面
- (void)jumpLogin{
    if (![[UserModel getInstance] getUserIsLogin]) {
        MainLoginViewController *login = [[MainLoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    }else{
        if (!_photoManager) {
            _photoManager =[[SelectPhotoManager alloc]init];
        }
        [_photoManager startSelectPhotoWithImageName:@"选择头像"];
        __weak typeof(self)mySelf=self;
        //选取照片成功
        _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
            
            mySelf.img = image;
            //保存到本地
            NSData *data = UIImagePNGRepresentation(image);
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
            [super viewWillAppear:YES];
            [mySelf.meTableView reloadData];
        };
    }
}

// 拨打客服电话
- (void)replySuccess{
    [self callPhone:@"400-085-0505"];
}

- (void)callPhone:(NSString *)phoneNumber{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

// 分享App
- (void)shareApp{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    NSString *icon = [[infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    
    //分享的标题
    NSString *textToShare = app_Name;
    //分享的图片
    UIImage *imageToShare = GetImage(icon);
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%d?mt=8",1465232582]];
    
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems;
    
    if (imageToShare == nil) {
        activityItems = @[textToShare,urlToShare];
    }else{
        activityItems = @[textToShare,imageToShare,urlToShare];
    }
    [ShareAppModel mq_share:activityItems target:self success:^(BOOL success) {
        
        
    }];
}

// 给个好评
-(void)gotoCommit{
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    }
}

// 我的收藏
-(void)myCollection{
    if ([[UserModel getInstance]getUserIsLogin]) {
        CollectionViewController *collection = [[CollectionViewController alloc]init];
        collection.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collection animated:YES];

    }else{
        MainLoginViewController *login = [[MainLoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    }
}

// 清理缓存
- (void)cleanSuccess{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存成功" message:@"点击确定返回" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

// 意见反馈
- (void)feedBack{
    FeedBackViewController *feed = [[FeedBackViewController alloc]init];
    feed.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feed animated:YES];
}

- (void)service{
    // 协议条款
    LocalViewController *loacal = [[LocalViewController alloc]init];
    loacal.hidesBottomBarWhenPushed = YES;
    loacal.titleStr = @"协议条款";
    loacal.localStr = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"html"];
    [self.navigationController pushViewController:loacal animated:YES];
}

- (void)pushToAboutUs{
    // 关于我们
    LocalViewController *loacal = [[LocalViewController alloc]init];
    loacal.hidesBottomBarWhenPushed = YES;
    loacal.localStr = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    loacal.titleStr = @"关于我们";
    [self.navigationController pushViewController:loacal animated:YES];
}

@end
