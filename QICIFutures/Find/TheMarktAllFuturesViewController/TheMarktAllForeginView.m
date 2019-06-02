//
//  TheMarktAllForeginView.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktAllForeginView.h"
#import "AllFuturesListTableViewCell.h"
#import "AllFuturesListHeader.h"

@implementation TheMarktAllForeginView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    self.type = AllFuturesInfoTypeForeignGoods;
    
    dispatch_async(dispatch_queue_create("AllForeignGoodsFutures.Queue", DISPATCH_QUEUE_CONCURRENT), ^{
        NSDictionary *dic = [SaveAndUseFuturesDataModel getAllForeignGoodsFuturesInfo];
        
        [self.dataDic removeAllObjects];
        [self.dataDic setValuesForKeysWithDictionary:dic];
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

-(NSMutableDictionary *)dataDic{
    
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
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
        _btnView = [[AllFuturesTopBtnView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) andBtns:@[@"商品期货",@"股指期货",@"外汇期货"]];
        [_btnView selectIndex:0];
        weakSelf(weakSelf);
        _btnView.btnClickBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                {
                    [weakSelf refreshWithType:AllFuturesInfoTypeForeignGoods];
                }
                    break;
                case 1:
                {
                    [weakSelf refreshWithType:AllFuturesInfoTypeForeignGuzhi];
                }
                    break;
                case 2:
                {
                    [weakSelf refreshWithType:AllFuturesInfoTypeForeignWaihui];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.type == AllFuturesInfoTypeForeignGoods) {
        return self.dataDic.allKeys.count;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.type == AllFuturesInfoTypeForeignGoods) {
        
        NSArray *arr = self.dataDic.allValues[section];
        
        return arr.count;
    }else{
        return self.dataArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.type == AllFuturesInfoTypeForeignGoods) {
        return 30;
    }else{
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.type == AllFuturesInfoTypeForeignGoods) {
        AllFuturesListHeader *view = [[AllFuturesListHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        NSString *key = self.dataDic.allKeys[section];
        [view loadTitle:key];
        return view;
    }else{
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AllFuturesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllFuturesListTableViewCell"];
    
    if (!cell) {
        cell = [[AllFuturesListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllFuturesListTableViewCell"];
    }
    
    if (self.type == AllFuturesInfoTypeForeignGoods) {
        NSArray *arr = self.dataDic.allValues[indexPath.section];
        
        [cell buildWithInfo:arr[indexPath.row]];
    }else{
        NSDictionary *dic = self.dataArray[indexPath.row];
        
        [cell buildWithInfo:dic];
    }
    
    if (indexPath.row < 15) {
        [cell requestInfos];
    }
    
    return cell;
}

-(void)refreshWithType:(AllFuturesInfoTypeForeign)type{
    
    self.type = type;
    
    switch (type) {
        case AllFuturesInfoTypeForeignGoods:
        {
            dispatch_async(dispatch_queue_create("AllForeignGoodsFutures.Queue", DISPATCH_QUEUE_CONCURRENT), ^{
                NSDictionary *dic = [SaveAndUseFuturesDataModel getAllForeignGoodsFuturesInfo];
                
                [self.dataDic removeAllObjects];
                [self.dataDic setValuesForKeysWithDictionary:dic];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.listView reloadData];
                });
                
            });
        }
            break;
        case AllFuturesInfoTypeForeignGuzhi:
        {
            dispatch_async(dispatch_queue_create("getAllGuzhiFutures.Queue", DISPATCH_QUEUE_CONCURRENT), ^{
                NSArray *array = [SaveAndUseFuturesDataModel getAllForeignStockIndexFuturesInfo];
                
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:array];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.listView reloadData];
                });
                
            });
        }
            break;
        case AllFuturesInfoTypeForeignWaihui:
        {
            dispatch_async(dispatch_queue_create("getAllWaihuiFutures.Queue", DISPATCH_QUEUE_CONCURRENT), ^{
                NSArray *array = [SaveAndUseFuturesDataModel getAllForeigncCurrencyFuturesInfo];
                
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
    
    NSDictionary *dic;
    if (self.type == AllFuturesInfoTypeForeignGoods) {
        NSArray *arr = self.dataDic.allValues[indexPath.section];
        dic = arr[indexPath.row];
    }else{
        dic = self.dataArray[indexPath.row];
    }
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
