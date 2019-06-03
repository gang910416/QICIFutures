//
//  QCHomeHeaderView.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <UIKit/UIKit.h>
@class QICIMarkeModel,QCNewsListModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^NewsDidSelectedBlock)(QCNewsListModel *newsModel);


typedef void(^IndexSelectedBlock)(QICIMarkeModel * _Nullable selectedListModel , BOOL isShowList);

typedef void(^SelectedMapViewBlock)(NSInteger index);

typedef void(^HeaderViewBTNSelectedBlock) (NSInteger Tag);

@interface QCHomeHeaderView : UIView
// 点击新闻
@property (copy, nonatomic) NewsDidSelectedBlock newsSelectedBlock;
// 点击指数
@property (copy, nonatomic) IndexSelectedBlock indexSelectedBlock;
// 点击MapView
@property (copy, nonatomic) SelectedMapViewBlock mapViewSelectedBlock;
@property (copy, nonatomic) HeaderViewBTNSelectedBlock btnSelectedBlock;
/** 点击资讯列表 */
@property (copy, nonatomic) dispatch_block_t newsListSelectedBlock;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
