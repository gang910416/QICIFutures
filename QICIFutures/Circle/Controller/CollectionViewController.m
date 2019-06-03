#import "CollectionViewController.h"
#import "CollectionTableViewCell.h"
#import "NewsDetailViewController.h"
#import "NoDataTableViewCell.h"
@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *collectionTbv;
@property (nonatomic,strong)NSMutableArray *likeArray;
@property (nonatomic,strong) NSDictionary *dataDic;
@end

@implementation CollectionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleSting = @"我的收藏";
    self.isHiddenBackButton = NO;
    [self configTableView];
}

- (void)requestData{
    self.likeArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"newsid"] mutableCopy];
    if (self.likeArray.count == 0) {
        [self.collectionTbv registerNib:[UINib nibWithNibName:@"NoDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoDataTableViewCell"];
        self.collectionTbv.rowHeight = SCREEN_HEIGHT-kDeviceNavHeight;
    }else{
        self.collectionTbv.rowHeight = 100;
        [self.collectionTbv registerNib:[UINib nibWithNibName:@"CollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectionTableViewCell"];
    }
    [self.collectionTbv reloadData];
}

- (void)configTableView{
    self.collectionTbv = [[UITableView alloc]initWithFrame:CGRectMake(0, kDeviceNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kDeviceNavHeight) style:UITableViewStyleGrouped];
    self.collectionTbv.delegate = self;
    self.collectionTbv.dataSource = self;
    [self.view addSubview:self.collectionTbv];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.likeArray.count == 0) {
        return 1;
    }else{
        return self.likeArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.likeArray.count == 0) {
        NoDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoDataTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
        if (!cell) {
            cell = [[CollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionTableViewCell"];
        }
        cell.contentLab.text = string([self.likeArray[indexPath.row] objectForKey:@"title"]);
        cell.dateLab.text = string([self.likeArray[indexPath.row] objectForKey:@"time"]);
        NSURL *url = [NSURL URLWithString:string([self.likeArray[indexPath.row] objectForKey:@"imgsrc1"])];
        [cell.img sd_setImageWithURL:url];
        [cell.img sd_setImageWithURL:url];
        [cell.img setContentMode:UIViewContentModeScaleAspectFill];
        
        cell.img.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]init];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.likeArray.count !=0) {
        NewsDetailViewController *detail = [[NewsDetailViewController alloc]init];
        detail.hidesBottomBarWhenPushed = YES;
        detail.newsid = [self.likeArray[indexPath.row] objectForKey:@"newsId"];
        detail.dataArr = self.likeArray[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}




@end
