//
//  AllFuturesListHeader.m
//  QCLC
//
//  Created by mac on 2019/5/24.
//

#import "AllFuturesListHeader.h"

@implementation AllFuturesListHeader

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    
    return _titleLabel;
}

-(void)loadTitle:(NSString *)title{
    
    self.titleLabel.text = title;
}

@end
