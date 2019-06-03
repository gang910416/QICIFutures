//
//  TheMarktLookFuturesCell.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktLookFuturesCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleInfoLabel;

@property (nonatomic,strong) UILabel *bodyInfoLabel;

@property (nonatomic,strong) UIView *backView;

-(void)buildWithTitle:(NSString *)title body:(NSString *)body backColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
