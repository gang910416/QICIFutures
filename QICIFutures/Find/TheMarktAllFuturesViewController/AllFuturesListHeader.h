//
//  AllFuturesListHeader.h
//  QCLC
//
//  Created by mac on 2019/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllFuturesListHeader : UIView

@property (nonatomic,strong) UILabel *titleLabel;

-(void)loadTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
