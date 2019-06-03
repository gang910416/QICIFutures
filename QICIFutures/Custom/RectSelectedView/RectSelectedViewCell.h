//
//  RectSelectedViewCell.h
//  kkcoin
//
//  Created by walker on 2018/8/15.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RectSelectedViewCell : UICollectionViewCell

/** 标签 */
@property (strong, nonatomic) UILabel *cellLabel;

/**  是否是选中状态 */
@property (assign, nonatomic) BOOL isSelected;

@end
