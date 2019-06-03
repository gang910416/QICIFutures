#import "NewsViewController.h"
#import "NewTableViewCell.h"
#import "NewsDetailViewController.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong)UITableView *newsTable;

@end

@implementation NewsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNewsTableView];
    self.newsTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [SVProgressHUD showWithStatus:@"正在加载..."];
        [self requestData];
    }];
    
}

- (void)configNewsTableView{
    self.newsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(kDeviceNavHeight+kDeviceTabBarHeight+44)) style:UITableViewStyleGrouped];
    self.newsTable.delegate = self;
    self.newsTable.dataSource = self;
    self.newsTable.rowHeight = 260;
    self.newsTable.showsVerticalScrollIndicator = NO;
    self.newsTable.showsHorizontalScrollIndicator = NO;
    [self.newsTable registerNib:[UINib nibWithNibName:@"NewTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewTableViewCell"];
    [self.view addSubview:self.newsTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewTableViewCell"];
    if (!cell) {
        cell =[[NewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewTableViewCell"];
    }
    if (self.dataArr.count!=0) {
        cell.date.text = string([self.dataArr[indexPath.row] objectForKey:@"time"]);
        cell.content.text = string([self.dataArr[indexPath.row] objectForKey:@"title"]);
        NSURL *url = [NSURL URLWithString:string([self.dataArr[indexPath.row] objectForKey:@"imgsrc1"])];
        [cell.img sd_setImageWithURL:url];
        [cell.img sd_setImageWithURL:url];
        [cell.img setContentMode:UIViewContentModeScaleAspectFill];
        
        cell.img.clipsToBounds = YES;
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
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
    if (self.dataArr.count != 0) {
        NewsDetailViewController *detail = [[NewsDetailViewController alloc]init];
        detail.hidesBottomBarWhenPushed = YES;
        detail.newsid = self.dataArr[indexPath.row][@"newsId"];
        detail.dataArr = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void)requestData{
    self.dataArr = [NSArray array];
    [self.newsTable.mj_header endRefreshing];
    
    [[HttpRequest sharedInstance]GETRequestWithUrl:@"http://sjzqbj.csc108.com:9800//api/news20/list?req_count=20&req_funType=L295&req_sinceId=0" paramaters:nil successBlock:^(id object, NSURLResponse *response) {
        NSLog(@"新闻数据%@",object);
        self.dataArr = object[@"news"];
        [self.newsTable reloadData];
        [SVProgressHUD dismiss];
    } FailBlock:^(NSError *error) {
        
    }];
}
@end
