//
//  CollectionTableViewCell.h
//  QICIFutures
//
//  Created by mac on 2019/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end

NS_ASSUME_NONNULL_END
