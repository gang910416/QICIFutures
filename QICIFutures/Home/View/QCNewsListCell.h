//
//  ASDNewsListCell.h
// ASDFutureProject
//
//  Created by Mac on 2019/4/29.
//  Copyright © 2019 ASD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCNewsListModel;
NS_ASSUME_NONNULL_BEGIN

@interface QCNewsListCell : UITableViewCell

- (void)updateDataWithModel:(QCNewsListModel *)model;

@end

NS_ASSUME_NONNULL_END
