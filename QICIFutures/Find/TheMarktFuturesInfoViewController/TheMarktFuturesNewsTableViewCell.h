//
//  TheMarktFuturesNewsTableViewCell.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <UIKit/UIKit.h>
#import "TheMarktNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktFuturesNewsTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleInfoLabel;

@property (nonatomic,strong) UILabel *bodyInfoLabel;

@property (nonatomic,strong) UILabel *timeInfoLabel;

@property (nonatomic,strong) UIImageView *newsImage;

-(void)buildWihtModel:(TheMarktNewsModel *)model;

@end

NS_ASSUME_NONNULL_END
