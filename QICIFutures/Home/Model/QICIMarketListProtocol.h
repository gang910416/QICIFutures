

#import <Foundation/Foundation.h>
@class QICIMarketListModel,QICIBaseListView;
@protocol QICIMarketListProtocol <NSObject>

/**
 列表视图被选中

 @param listView 列表视图
 @param listModel 选中的模型
 @param indexPath 选中的位置
 */
- (void)delegate_marketListView:(QICIBaseListView *)listView didSelectedModel:(QICIMarketListModel *)listModel indexPath:(NSIndexPath *)indexPath;

/**
 数据加载完成

 @param listView 列表视图
 */
- (void)delegate_marketListViewDidLoadData:(QICIBaseListView *)listView;

/**
 需要展示搜索界面

 @param listView 列表
 */
- (void)delegate_marketListViewShouldShowSearch:(QICIBaseListView *)listView;
@end
