#import "MeViewController.h"
#import "MeTableViewCell.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *meTableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
}

- (void)configTableView{
    self.meTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kDeviceNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(kDeviceNavHeight+kDeviceTabBarHeight)) style:UITableViewStyleGrouped];
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    self.meTableView.tableHeaderView = self.headerView;
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.rowHeight = 50;
    [self.meTableView registerNib:[UINib nibWithNibName:@"MeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeTableViewCell"];
    [self.view addSubview:self.meTableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell"];
    if (!cell) {
        cell = [[MeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

@end
