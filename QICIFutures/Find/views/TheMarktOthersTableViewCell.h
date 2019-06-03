//
//  TheMarktOthersTableViewCell.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktOthersTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *leftBackView;

@property (nonatomic,strong) UIView *rightBackView;

@property (nonatomic,strong) UILabel *leftTitleLabel;

@property (nonatomic,strong) UILabel *rightTitleLabel;

@property (nonatomic,strong) UILabel *leftInfoLabel;

@property (nonatomic,strong) UILabel *rightInfoLabel;

@property (nonatomic,strong) UIButton *leftBtn;

@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,copy) void(^othersBtnClickBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
