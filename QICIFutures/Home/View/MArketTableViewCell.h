//
//  MArketTableViewCell.h
//  QICIFutures
//
//  Created by mac on 2019/5/31.
//

#import <UIKit/UIKit.h>
@class QICIMarkeModel ;
NS_ASSUME_NONNULL_BEGIN

@interface MArketTableViewCell : UITableViewCell

-(void)updataWithMarketModel:(QICIMarkeModel *)model indexPath:(NSIndexPath *)index;;

@end

NS_ASSUME_NONNULL_END
