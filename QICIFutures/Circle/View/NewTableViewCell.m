//
//  NewTableViewCell.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "NewTableViewCell.h"

@implementation NewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
//    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
