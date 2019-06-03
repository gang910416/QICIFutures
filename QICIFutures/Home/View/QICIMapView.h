


NS_ASSUME_NONNULL_BEGIN

@protocol HOMEButtonsViewDelegate <NSObject>

/**
 @param index e按钮点击的下标
 */
- (void)delegate_touchBtnWithIndex:(NSInteger)index;

@end


@interface QCButtonsView : UIView

/** 代理 */
@property (weak, nonatomic) id <HOMEButtonsViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles icons:(NSArray *)icons;

@end

NS_ASSUME_NONNULL_END
