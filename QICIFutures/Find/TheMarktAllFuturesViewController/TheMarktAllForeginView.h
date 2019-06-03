//
//  TheMarktAllForeginView.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <UIKit/UIKit.h>

#import "AllFuturesTopBtnView.h"

typedef enum : NSUInteger {
    AllFuturesInfoTypeForeignGoods,
    AllFuturesInfoTypeForeignGuzhi,
    AllFuturesInfoTypeForeignWaihui,
} AllFuturesInfoTypeForeign;

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktAllForeginView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

-(void)refreshWithType:(AllFuturesInfoTypeForeign)type;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableDictionary *dataDic;

@property (nonatomic,assign) AllFuturesInfoTypeForeign type;

@property (nonatomic,strong) AllFuturesTopBtnView *btnView;

@property (nonatomic,copy) void(^selectRowBlock)(NSDictionary *dic);

@property (nonatomic,copy) void(^selectBtnBlock)(NSString *title);

@end

NS_ASSUME_NONNULL_END
