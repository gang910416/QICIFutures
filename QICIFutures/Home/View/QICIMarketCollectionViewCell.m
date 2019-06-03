

#import "QICIMarketCollectionViewCell.h"
#import "QICITitleMoreToolView.h"

@interface QICIMarketCollectionViewCell ()

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UILabel *priceLabel;

@property (strong, nonatomic) UILabel *changePercentLabel;

@property (strong, nonatomic) QICIMarkeModel *listModel;

@end

@implementation QICIMarketCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self cell_wrfg:@[@"2",@"3"]  string:@"qwert" num:@(0)];
        self.contentView.backgroundColor = QICIColorGap;
        self.contentView.layer.cornerRadius = SCALE_Length(5.0f);
        self.contentView.layer.masksToBounds = YES;
        [self p_asd_configUI];
    }
    return self;
}

- (void)p_asd_configUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.changePercentLabel];
    
    [self p_layout];
}

- (void)p_layout {
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(SCALE_Length(10.0));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(SCALE_Length(10.0));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.changePercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(SCALE_Length(10.0));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
}


- (void)updateWithDataModel:(QICIMarkeModel *)model {
    if (model) {
        self.listModel = model;
        
        [self p_refreshUI];
    }
}

- (void)p_refreshUI {
    
    self.nameLabel.text = self.listModel.prod_name;
    self.priceLabel.text = [NSString gl_convertToDisplayStringWithOriginNum:[NSString stringWithFormat:@"%@",self.listModel.last_px] decimalsLimit:3 prefix:@"" suffix:@""];
    
    UIColor *color = QICIColorTitle;
    NSComparisonResult result = [[self.listModel.px_change_rate gl_digitalValue] compare:@(0)];
    if (result == NSOrderedDescending) {
        // 降序大于0
                color = QICIColorLong;
        self.changePercentLabel.text = [NSString gl_convertToDisplayStringWithOriginNum:[NSString stringWithFormat:@"%@",self.listModel.px_change_rate] decimalsLimit:2 prefix:@"+" suffix:@"%"];
//        self.contentView.backgroundColor = [ASDColorLong colorWithAlphaComponent:0.8];
        
    }else if(result == NSOrderedAscending) {
        // 升序，小于0
                color = QICIColorShort;
        self.changePercentLabel.text = [NSString gl_convertToDisplayStringWithOriginNum:[NSString stringWithFormat:@"%@",self.listModel.px_change_rate] decimalsLimit:2 prefix:@"-" suffix:@"%"];
//        self.contentView.backgroundColor = [ASDColorShort colorWithAlphaComponent:0.8];
    }else {
        self.changePercentLabel.text = @"0.00%";
//        self.contentView.backgroundColor = ASDColorGap;
    }
    
    self.priceLabel.textColor = color;
    self.changePercentLabel.textColor = color;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont fontWithName:fFont size:15.0f];
        _nameLabel.textColor = QICIColorTitle;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"--";
        
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _priceLabel.textColor = QICIColorTipText;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.text = @"--";
    }
    return _priceLabel;
}

- (UILabel *)changePercentLabel {
    if (!_changePercentLabel) {
        _changePercentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _changePercentLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _changePercentLabel.textColor = QICIColorTipText;
        _changePercentLabel.textAlignment = NSTextAlignmentCenter;
        _changePercentLabel.text = @"--";
    }
    return _changePercentLabel;
}

@end
