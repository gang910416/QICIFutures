//
//  QCBtnSView.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HOMEBTNSViewDelegate <NSObject>

/**
 @param index 下标
 */
- (void)delegate_touchBtnWithIndex:(NSInteger)index;

@end
@interface QCBtnSView : UIView
/** 代理 */
@property (weak, nonatomic) id <HOMEBTNSViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles icons:(NSArray *)icons;
@end

NS_ASSUME_NONNULL_END
