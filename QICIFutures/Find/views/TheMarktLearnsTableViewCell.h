//
//  TheMarktLearnsTableViewCell.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktLearnsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UILabel *titleInfoLabel;

@property (nonatomic,strong) UILabel *info1Label;

@property (nonatomic,strong) UILabel *info2Label;

@property (nonatomic,strong) UILabel *info3Label;

@property (nonatomic,strong) UIImageView *infoImageView;

@property (nonatomic,strong) UIButton *seeBtn;

@property (nonatomic,copy) void(^jumpToLearnView)(void);

@end

NS_ASSUME_NONNULL_END
