//
//  TheMarktScrollNewsTableViewCell.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <UIKit/UIKit.h>
#import "TheMarktFastNewsScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktScrollNewsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UILabel *infoLabel;

@property (nonatomic,strong) UIImageView *infoImageView;

@property (nonatomic,strong) TheMarktFastNewsScrollView *fastNewsView;

@end

NS_ASSUME_NONNULL_END
