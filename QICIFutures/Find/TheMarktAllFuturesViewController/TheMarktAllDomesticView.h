//
//  TheMarktAllDomesticView.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <UIKit/UIKit.h>
#import "AllFuturesTopBtnView.h"

typedef enum : NSUInteger {
    AllFuturesInfoTypeDomesticAll,
    AllFuturesInfoTypeDomesticOil,
} AllFuturesInfoTypeDomestic;

@interface TheMarktAllDomesticView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

-(void)refreshWithType:(AllFuturesInfoTypeDomestic)type;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) AllFuturesInfoTypeDomestic type;

@property (nonatomic,strong) AllFuturesTopBtnView *btnView;

@property (nonatomic,copy) void(^selectRowBlock)(NSDictionary *dic);

@property (nonatomic,strong) NSMutableArray *headArray;

@end
