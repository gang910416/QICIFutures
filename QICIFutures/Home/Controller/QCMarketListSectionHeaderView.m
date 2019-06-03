

#import "QCMarketListSectionHeaderView.h"
#import "UIView+Frame.h"

@interface QCMarketListSectionHeaderView ()

/** 股票label */
@property (strong, nonatomic) UILabel *guplLabel;

/** 价格label */
@property (strong, nonatomic) UILabel *priceLabel;

/** 涨跌label */
@property (strong, nonatomic) UILabel *changeLabel;

/* 传入的标题 */
@property (strong, nonatomic) NSArray *titles;

@end

@implementation QCMarketListSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    
    if (self = [super initWithFrame:frame]) {

        if(titles && titles.count > 0) {
            self.titles = [titles copy];
        }

        self.backgroundColor = QICIColorGap;
        self.guplLabel.text = @"期货";
        self.priceLabel.text = @"最新价格";
        self.changeLabel.text = @"涨跌幅";
        
        [self p_asd_configUI];

        [self p_setUpTitle];
    }
    return self;
}

- (void)p_asd_configUI {

    [self addSubview:self.guplLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.changeLabel];

    [self layoutWithMasonry];
}

- (void)layoutWithMasonry {

    [self.guplLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.mas_left).mas_offset(SCALE_Length(10.0f));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(SCALE_Length(160.0f));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(SCALE_Length(180.0f));
        make.centerY.equalTo(self.mas_centerY);
    }];

    [self.changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10.0f));
        make.centerY.equalTo(self.mas_centerY);
    }];

}

- (void)p_setUpTitle {

    if(self.titles && self.titles.count >= 3) {

        self.guplLabel.text = [self.titles objectAtIndex:0];
        self.priceLabel.text = [self.titles objectAtIndex:1];
        self.changeLabel.text = [self.titles objectAtIndex:2];

    }
}

- (void)updateWithTitles:(NSArray * _Nullable)titles {
    
    if (titles && titles.count >= 3) {
        self.titles = [titles copy];
        
        [self p_setUpTitle];
    }
}

- (UILabel *)guplLabel {
    if (!_guplLabel) {
        _guplLabel = [[UILabel alloc] init];
        _guplLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _guplLabel.textColor = QICIColorNormalText;
    }
    return _guplLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _priceLabel.textColor =QICIColorNormalText;
    }
    return _priceLabel;
}

- (UILabel *)changeLabel {
    if (!_changeLabel) {
        _changeLabel = [[UILabel alloc] init];
        _changeLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _changeLabel.textColor = QICIColorNormalText;
    }
    return _changeLabel;
}

@end
