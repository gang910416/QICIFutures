//
//  AllFuturesTopBtnView.h
//  QCLC
//
//  Created by mac on 2019/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllFuturesTopBtnView : UIView

-(instancetype)initWithFrame:(CGRect)frame andBtns:(NSArray *)btnArray;

@property (nonatomic,strong) NSMutableArray *btnArray;

-(void)selectIndex:(NSInteger)i;

@property (nonatomic,copy) void(^btnClickBlock)(NSInteger index);

-(void)refreshWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
