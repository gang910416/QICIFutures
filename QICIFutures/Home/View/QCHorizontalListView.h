


@class QCHorizontalListView;
NS_ASSUME_NONNULL_BEGIN

@protocol QICIHorizontalListViewDelegate <NSObject>

/**
 传入自定义cell的类

 @param listView 横向列表
 @return 自定义cell 的类
 */
- (Class _Nullable)customCollectionViewCellClassForHorizontalView:(QCHorizontalListView *)listView;

/**
 自定义cell数据处理

 @param listView 横向列表
 @param cell 横向列表的cell
 @param dataSource 数据源
 @param indexPath 位置
 */
- (void)horizontalView:(QCHorizontalListView *)listView setUpCell:(UICollectionViewCell *)cell dataSource:(NSArray *)dataSource forItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)horizontalView:(QCHorizontalListView *)listView didSelectedMoreBtn:(UIButton *)moreBtn;

- (void)horizontalView:(QCHorizontalListView *)listView didSelectedModel:(id)model indexPath:(NSIndexPath *)indexPath;

@end


typedef void(^SelectedMoreBtnBlock)(QCHorizontalListView *listView, UIButton *moreBtn);

@interface QCHorizontalListView : UIView

@property (weak, nonatomic) id<QICIHorizontalListViewDelegate> delegate;

/**
 更多事件的回调
 */
@property (copy, nonatomic) SelectedMoreBtnBlock moreActionBlock;

/**
 标识符
 */
@property (strong, nonatomic) NSString *identifier;

- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier;

/** 更新item的大小 */
- (void)setUpItemSize:(CGSize)itemSize;

/**
 更新标题和更多按钮标题
 */
- (void)updateTitle:(NSString *)title moreBtnTitle:(NSString *)moreTitle;

/** 刷新列表  */
- (void)reloadListViewWithDataSource:(NSArray *)dataSource;

- (void)updateDataSource:(NSArray *)dataSource;

- (void)reloadListView;

@end

NS_ASSUME_NONNULL_END
