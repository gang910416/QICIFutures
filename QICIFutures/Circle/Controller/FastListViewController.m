#import "FastListViewController.h"
#import "CollectionViewController.h"
@interface FastListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) UITableView *newsTable;

@end

@implementation FastListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNewsTableView];
    
    self.newsTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [SVProgressHUD show];
        [self requestData];
    }];
}

- (void)configNewsTableView{
    self.newsTable = [[UITableView alloc]init];
    self.newsTable.delegate = self;
    self.newsTable.dataSource = self;
    [self.newsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.newsTable.showsVerticalScrollIndicator = NO;
    self.newsTable.showsHorizontalScrollIndicator = NO;
    [self.newsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.newsTable];
    [self.newsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }else{
        while (cell.contentView.subviews.lastObject != nil) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    if (self.dataArr.count!=0) {
        UILabel *deteL = [[UILabel alloc]init];
        deteL.textColor = [UIColor darkTextColor];
        deteL.font = [UIFont systemFontOfSize:12];
        deteL.numberOfLines = 0;
        deteL.textAlignment = NSTextAlignmentCenter;
       
//        // timeStampString 是服务器返回的13位时间戳
        NSString *timeStampString  = string([self.dataArr[indexPath.row] objectForKey:@"UpdateTime"]);

        // iOS 生成的时间戳是10位
        NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
        NSDate *date               = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        NSString *dateString       = [formatter stringFromDate: date];
        NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
        deteL.text = dateString;
        [cell.contentView addSubview:deteL];
        
        UILabel *contentL = [[UILabel alloc]init];
        contentL.numberOfLines = 0;
        [cell.contentView addSubview:contentL];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[[self.dataArr[indexPath.row] objectForKey:@"Title"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:25.0f] } documentAttributes:nil error:nil];
        
        contentL.attributedText = attrStr;//用于显示
        contentL.font = [UIFont systemFontOfSize:15];
        
        CGFloat height = [self getWidth:SCREEN_WIDTH*0.65 title:string([self.dataArr[indexPath.row] objectForKey:@"Title"]) font:[UIFont systemFontOfSize:16]];
        contentL.frame = CGRectMake( SCREEN_WIDTH*0.3, 10, SCREEN_WIDTH*0.65, height);
    
        if (contentL.frame.size.height < SCREEN_WIDTH*0.2) {
            tableView.rowHeight = SCREEN_WIDTH*0.2;
        }else{
            tableView.rowHeight = contentL.frame.size.height+30;
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2+12, 0, 1, tableView.rowHeight)];
        line.backgroundColor = LineColor;
        [cell.contentView addSubview:line];
        UIView *moreV = [[UIView alloc]init];
        moreV.backgroundColor = [UIColor redColor];
        LXViewRadius(moreV, 3);
        [cell.contentView addSubview:moreV];
        [moreV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.mas_equalTo(line.mas_centerX);
            make.width.mas_offset(6);
            make.height.mas_offset(6);
            
        }];
        [deteL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(moreV.mas_centerY);
            make.left.mas_offset(SCREEN_WIDTH*0.05);
            make.width.mas_offset(SCREEN_WIDTH*0.15);
        }];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

// 计算label高度
- (CGFloat)getWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    // 创建一个label对象，给出目标label的宽度
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    // 获得文字
    label.text = title;
    // 获得字体大小
    label.font = font;
    // 自适应
    label.numberOfLines = 0;
    [label sizeToFit];
    // 经过自适应之后的label，已经有新的高度
    CGFloat height = label.frame.size.height;
    // 返回高度
    return height;
}

- (void)requestData{
    self.dataArr = [NSArray array];
    [self.newsTable.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [[HttpRequest sharedInstance]GETRequestWithUrl:@"https://mapi.followme.com/app/v1/social2/fire/news?pageIndex=1" paramaters:nil successBlock:^(id object, NSURLResponse *response) {
        self.dataArr = object[@"data"][@"Items"][0][@"Items"];
        [self.newsTable reloadData];
    } FailBlock:^(NSError *error) {
        
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

@end
