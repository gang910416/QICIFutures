//
//  SearchResultchartsTableViewCell.h
//  QCLC
//
//  Created by mac on 2019/5/27.
//

#import <UIKit/UIKit.h>
#import <QCStockLineView.h>
#import "FuturesKModel.h"
#import "AllFuturesTopBtnView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultchartsTableViewCell : UITableViewCell

@property (nonatomic,strong) QCStockLineView *kView;

@property (nonatomic,strong) AllFuturesTopBtnView *btnView;

-(void)refreshWithData:(NSArray *)dataArray type:(NSString *)type;

@property (nonatomic,copy) void(^requestKLineType)(NSInteger type);

@end

NS_ASSUME_NONNULL_END
