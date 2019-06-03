//
//  TheMarktAllDomesticView.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktAllDomesticView.h"
#import "AllFuturesListTableViewCell.h"

@implementation TheMarktAllDomesticView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

-(NSMutableArray *)headArray{
    
    if (!_headArray) {
        _headArray = [NSMutableArray array];
    }
    return _headArray;
}

-(void)configUI{
    
    self.type = AllFuturesInfoTypeDomesticAll;
    
    self.listView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    dispatch_async(dispatch_queue_create("AllDomesticFutures.Queue", DISPATCH_QUEUE_CONCURRENT), ^{
        NSArray *array = [SaveAndUseFuturesDataModel getAllDomesticFuturesInfo];
        
        
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.listView reloadData];
        });
        
    });
    
    [self addSubview:self.listView];
    [self addSubview:self.btnView];
    
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)listView{
    
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.width, self.height-50) style:UITableViewStyleGrouped];
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listView;
}

-(AllFuturesTopBtnView *)btnView{
    
    if (!_btnView) {
        _btnView = [[AllFuturesTopBtnView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) andBtns:@[@"国内全部",@"菜油期货"]];
        [_btnView selectIndex:0];

        weakSelf(self);

        _btnView.btnClickBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                {
                    [weakSelf refreshWithType:AllFuturesInfoTypeDomesticAll];
                    if (weakSelf.selectBtnBlock) {
                        weakSelf.selectBtnBlock(@"国内全部");
                    }
                }
                    break;
                case 1:
                {
                    [weakSelf refreshWithType:AllFuturesInfoTypeDomesticOil];
                    if (weakSelf.selectBtnBlock) {
                        weakSelf.selectBtnBlock(@"菜油期货");
                    }
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _btnView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AllFuturesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllFuturesListTableViewCell"];
    
    if (!cell) {
        cell = [[AllFuturesListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllFuturesListTableViewCell"];
    }
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    [cell buildWithInfo:dic];
    
    if (indexPath.row < 15) {
        [cell requestInfos];
        
    }
    
    return cell;
}


-(void)refreshWithType:(AllFuturesInfoTypeDomestic)type{
    
    self.type = type;
    
    switch (type) {
        case AllFuturesInfoTypeDomesticAll:
        {
            dispatch_async(dispatch_queue_create("AllDomesticFutures.Queue", DISPATCH_QUEUE_CONCURRENT), ^{
                NSArray *array = [SaveAndUseFuturesDataModel getAllDomesticFuturesInfo];
                
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:array];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.listView reloadData];
                });
                
            });
        }
            break;
        case AllFuturesInfoTypeDomesticOil:
        {
            dispatch_async(dispatch_queue_create("AllDomesticVegetableOilFutures.Queue", DISPATCH_QUEUE_CONCURRENT), ^{
                NSArray *array = [SaveAndUseFuturesDataModel getAllDomesticVegetableOilFuturesInfo];
                
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:array];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.listView reloadData];
                });
                
            });
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    if (self.selectRowBlock) {
        self.selectRowBlock(dic);
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSArray *arr = self.listView.visibleCells;
    for (AllFuturesListTableViewCell *cell in arr) {
        [cell requestInfos];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (decelerate) {
        NSArray *arr = self.listView.visibleCells;
        for (AllFuturesListTableViewCell *cell in arr) {
            [cell requestInfos];
        }
    }
}

@end
