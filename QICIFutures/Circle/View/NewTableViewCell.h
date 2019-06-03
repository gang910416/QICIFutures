//
//  NewTableViewCell.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

NS_ASSUME_NONNULL_END
