//
//  noDataView.m
//  QCLC
//
//  Created by mac on 2019/5/30.
//

#import "noDataView.h"

@implementation noDataView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

-(UIImageView *)noDataImage{
    
    if (!_noDataImage) {
        _noDataImage = [[UIImageView alloc] init];
        [_noDataImage setImage:imageWithName(@"NoDataImage")];
    }
    return _noDataImage;
}

-(UILabel *)noDataLabel{
    
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        _noDataLabel.text = @"暂无数据";
        _noDataLabel.textColor = HexColor(0x8a8a8a);
        _noDataLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noDataLabel;
}

-(void)configUI{
    
    [self addSubview:self.noDataImage];
    [self addSubview:self.noDataLabel];
}

-(void)layoutSubviews{
    
    [self.noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.noDataImage.mas_bottom).mas_offset(10);
        
    }];
}

@end
