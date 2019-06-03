

#import <UIKit/UIKit.h>
@class ASDMarketListModel;
NS_ASSUME_NONNULL_BEGIN

@interface ASDMarketListCell : UITableViewCell
- (void)updateWithDataModel:(ASDMarketListModel *)model indexPath:(NSIndexPath *)index;

@end

NS_ASSUME_NONNULL_END
