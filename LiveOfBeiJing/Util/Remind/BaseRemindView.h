//
//  BaseRemindView.h
//  LiveOfBeiJing
//
//  Created by Bingo on 2018/11/29.
//

#import <UIKit/UIKit.h>

@class BaseRemindView;
NS_ASSUME_NONNULL_BEGIN
@protocol BaseRemindViewDelegate <NSObject>

- (void)remindView:(BaseRemindView *)remindView didPressFirstButton:(UIButton *)firstButton;

@end
@interface BaseRemindView : UIView
-(instancetype)instanceViewWithFrame:(CGRect)frame;
@property (nonatomic, copy) NSString *remindImgString;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *messageString;
@property (nonatomic, copy) NSString *firstButtonString;
@property (nonatomic, copy) NSString *cannelButtonString;



@property (nonatomic, weak) id<BaseRemindViewDelegate> remindViewDelegate;
@end

NS_ASSUME_NONNULL_END
