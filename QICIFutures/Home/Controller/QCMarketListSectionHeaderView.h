



NS_ASSUME_NONNULL_BEGIN

@interface QCMarketListSectionHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray * _Nullable)titles;

- (void)updateWithTitles:(NSArray * _Nullable)titles;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
