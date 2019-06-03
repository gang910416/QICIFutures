


@class QICITitleMoreToolView;

NS_ASSUME_NONNULL_BEGIN
@protocol ASDTitleMoreToolViewDelegate <NSObject>

- (void)titleMoreToolView:(QICITitleMoreToolView *)view didSelectedMoreBtn:(UIButton *)moreBtn;

@end

@interface QICITitleMoreToolView : UIView

@property (weak, nonatomic) id <ASDTitleMoreToolViewDelegate> delegate;

@property (readonly, strong, nonatomic, nonnull) NSString *titleString;

@property (readonly, strong, nonatomic, nullable) NSString *moreBtnTitle;

- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString * _Nullable)titleString moreBtnTitle:(NSString * _Nullable)moreBtnString;

- (void)updateTitleString:(NSString * _Nullable)titleString moreBtnString:(NSString *_Nullable)moreBtnString;

@end

NS_ASSUME_NONNULL_END
