

#import "QICIMarketListSectionHeaderView.h"
#import "UIView+Frame.h"

@interface QICIMarketListSectionHeaderView ()

/** 股票label */
@property (strong, nonatomic) UILabel *symbolLabel;

/** 价格label */
@property (strong, nonatomic) UILabel *priceLabel;

/** 涨跌label */
@property (strong, nonatomic) UILabel *chgLabel;

/* 传入的标题 */
@property (strong, nonatomic) NSArray *titles;

@end

@implementation QICIMarketListSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    
    if (self = [super initWithFrame:frame]) {

        if(titles && titles.count > 0) {
            self.titles = [titles copy];
        }

       
        
        [self p_asd_configUI];

        [self p_setUpTitle];
    }
    return self;
}

- (void)p_asd_configUI {

    [self addSubview:self.symbolLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.chgLabel];

    [self layoutWithMasonry];
}

- (void)layoutWithMasonry {
    
    self.backgroundColor = QICIColorGap;
    self.symbolLabel.text = @"期货";
    self.priceLabel.text = @"最新价格";
    self.chgLabel.text = @"涨跌幅";
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.mas_left).mas_offset(SCALE_Length(10.0f));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(SCALE_Length(160.0f));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(SCALE_Length(180.0f));
        make.centerY.equalTo(self.mas_centerY);
    }];

    [self.chgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10.0f));
        make.centerY.equalTo(self.mas_centerY);
    }];

}

- (void)p_setUpTitle {

    if(self.titles && self.titles.count >= 3) {

        self.symbolLabel.text = [self.titles objectAtIndex:0];
        self.priceLabel.text = [self.titles objectAtIndex:1];
        self.chgLabel.text = [self.titles objectAtIndex:2];

    }
}

- (void)updateWithTitles:(NSArray * _Nullable)titles {
    
    if (titles && titles.count >= 3) {
        self.titles = [titles copy];
        
        [self p_setUpTitle];
    }
}

- (UILabel *)symbolLabel {
    if (!_symbolLabel) {
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _symbolLabel.textColor = QICIColorNormalText;
    }
    return _symbolLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _priceLabel.textColor = QICIColorNormalText;
    }
    return _priceLabel;
}

- (UILabel *)chgLabel {
    if (!_chgLabel) {
        _chgLabel = [[UILabel alloc] init];
        _chgLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _chgLabel.textColor = QICIColorNormalText;
    }
    return _chgLabel;
}

@end
