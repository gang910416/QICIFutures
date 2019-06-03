//
//  RectSelectedViewCell.m
//  kkcoin
//
//  Created by walker on 2018/8/15.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "RectSelectedViewCell.h"

@implementation RectSelectedViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self cell_wrfg:@[@"2",@"3"]  string:@"qwert" num:@(0)];
        
        self.contentView.backgroundColor = [UIColor darkGrayColor];
        
        [self p_asd_configUI];
    }
    return self;
}

- (void)prepareForReuse {
    self.cellLabel.text = @"";
    [self setIsSelected:NO];
}

#pragma mark - 私有方法 --

- (void)p_asd_configUI {
    
    [self.contentView addSubview:self.cellLabel];
    
    [self p_layoutWithMasonry];
}

- (void)p_layoutWithMasonry {
    
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

#pragma mark - 公共方法 --

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    if (_isSelected) {
        
        _cellLabel.layer.borderColor = QICIColorTheme.CGColor;
        _cellLabel.textColor = QICIColorTheme;
    }else {
        
        _cellLabel.layer.borderColor = QICIColorSeparator.CGColor;
        _cellLabel.textColor = QICIColorTipText;
    }
}

#pragma mark - 懒加载 --

- (UILabel *)cellLabel {
    if(!_cellLabel) {
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.userInteractionEnabled = YES;
        _cellLabel.backgroundColor = QICIColorGap;
        _cellLabel.textColor = QICIColorTipText;
        _cellLabel.textAlignment = NSTextAlignmentCenter;
        _cellLabel.font = [UIFont kk_systemFontOfSize:15.0f];
        _cellLabel.layer.borderColor = QICIColorSeparator.CGColor;
        _cellLabel.layer.borderWidth = 1.0f;
    }
    return _cellLabel;
}

@end
