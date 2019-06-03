#import "CircleViewController.h"
#import "TYPagerController.h"
#import "TYTabPagerBar.h"
#import "NewsViewController.h"
#import "FastListViewController.h"
#import "CalendarViewController.h"

@interface CircleViewController ()<TYTabPagerBarDelegate,TYTabPagerBarDataSource,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerController *pagerController;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleSting = @"资讯";
    [self loadData];
    
    self.navBackGroundColor = RGBColor(235, 85, 75);
    self.navTitleColor = [UIColor whiteColor];
    self.isHiddenShadow = YES;
    [self addTabPageBar];
    [self addPagerController];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)addTabPageBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
//    tabBar.backgroundColor = RGBColor(235, 85, 75);
    tabBar.layout.cellWidth = SCREEN_WIDTH / 3;
    tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    tabBar.dataSource = self;
    tabBar.delegate = self;
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)addPagerController {
    TYPagerController *pagerController = [[TYPagerController alloc]init];
    pagerController.layout.prefetchItemCount = 1;
    //pagerController.layout.autoMemoryCache = NO;
    // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
    pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    pagerController.dataSource = self;
    pagerController.delegate = self;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, kDeviceNavHeight, SCREEN_WIDTH, 44);
    _pagerController.view.frame = CGRectMake(0, 44+kDeviceNavHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- CGRectGetMaxY(_tabBar.frame));
}


#pragma mark - TYTabPagerBarDataSource

- (NSInteger)numberOfItemsInPagerTabBar {
    return 3;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = _datas[index];
    cell.titleLabel.textColor = [UIColor blackColor];
    
    return cell;
}

#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    
    NSString *title = _datas[index];
    
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    return 3;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        NewsViewController *VC = [[NewsViewController alloc]init];
        return VC;
    }else if(index == 1){
        FastListViewController *VC = [[FastListViewController alloc]init];
        return VC;
    }else{
        CalendarViewController *VC = [[CalendarViewController alloc]init];
        return VC;
    }
}

#pragma mark - TYPagerControllerDelegate

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}
- (void)reloadData {
    [_tabBar reloadData];
    [_pagerController reloadData];
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray arrayWithObjects:@"新闻",@"快讯",@"日历",nil];
    _datas = [datas copy];
    [self reloadData];
    
}

@end
