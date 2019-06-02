//
//  AllFuturesListTableViewCell.h
//  QCLC
//
//  Created by mac on 2019/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllFuturesListTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *idLabel;

@property (nonatomic,strong) UILabel *infoLabel;

@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) UILabel *priceInfo;

@property (nonatomic,copy) NSString *fuId;

-(void)buildWithInfo:(NSDictionary *)dic;

-(void)requestInfos;

@end

NS_ASSUME_NONNULL_END
