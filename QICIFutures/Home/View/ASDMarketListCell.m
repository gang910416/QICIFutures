

#import "ASDMarketListCell.h"

@interface ASDMarketListCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *codeLabel;

@property (strong, nonatomic) UILabel *tradeLabel;

@property (strong, nonatomic) UIButton *priceChangePercent;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) QICIMarkeModel *model;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end
@implementation ASDMarketListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self cell_wrfg:@[@"2",@"3"]  string:@"qwert" num:@(0)];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLabel.text = @"--";
        self.codeLabel.text = @"--";
        self.tradeLabel.text = @"--";
        
        [self.priceChangePercent setTitle:@"-%" forState:UIControlStateNormal];
        
        self.backgroundColor = QICIColorMarketDetail;
        
        [self p_asd_configUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)updateWithDataModel:(QICIMarkeModel *)model indexPath:(NSIndexPath *)index {
    
    if (model) {
        self.model = model;
    }
    
    if (index) {
        self.indexPath = index;
    }
    
    [self p_updateData];
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.text = @"--";
    self.codeLabel.text = @"--";
    self.tradeLabel.text = @"--";
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.priceChangePercent setTitle:@"-%" forState:UIControlStateNormal];
}

#pragma mark - 私有方法 ---


- (void)p_asd_configUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.codeLabel];
    [self.contentView addSubview:self.tradeLabel];
    [self.contentView addSubview:self.priceChangePercent];
    [self.contentView addSubview:self.lineView];
    
    [self p_layoutWithMasonry];
}

- (void)p_layoutWithMasonry {
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(SCALE_Length(1.0f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.contentView.mas_top).offset(SCALE_Length(10.0f));
        make.width.mas_equalTo(SCALE_Length(160.0f));
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_Length(5.0f));
    }];
    
    [self.tradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(180.0f));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.priceChangePercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(SCALE_Length(- 10.0f));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SCALE_Length(80.0f), SCALE_Length(30.0f)));
    }];
    
}

- (void)p_updateData {
    
    if (self.model) {
        self.titleLabel.text = self.model.prod_name;
        self.codeLabel.text = self.model.prod_code;
        self.tradeLabel.text = [NSString gl_fixNumString:[NSString stringWithFormat:@"%@",self.model.last_px] minDecimalsLimit:2 maxDecimalsLimit:2];
        
        
        NSString *percent = [NSString gl_fixNumString:[NSString stringWithFormat:@"%@",self.model.px_change_rate] minDecimalsLimit:2 maxDecimalsLimit:2];
        [self.priceChangePercent setTitle:[NSString stringWithFormat:@"%@%%",percent] forState:UIControlStateNormal];
        NSDecimalNumber *change = [self.model.px_change_rate gl_digitalValue];
        NSComparisonResult result = [change compare:@(0)];
        [self.priceChangePercent setTitleColor:QICIColorTitle forState:UIControlStateNormal];
        
        if (result == NSOrderedAscending) {
            // 小于0
            [self.priceChangePercent setBackgroundColor:QICIColorShort];
            //            [self.priceChangePercent setTitleColor:ASDColorShort forState:UIControlStateNormal];
        }else if(result == NSOrderedDescending){
            // 大于0
            [self.priceChangePercent setBackgroundColor:QICIColorLong];
            //            [self.priceChangePercent setTitleColor:ASDColorLong forState:UIControlStateNormal];
            
        }else {
            [self.priceChangePercent setBackgroundColor:QICIColorBorder];
            //            [self.priceChangePercent setTitleColor:ASDColorBorder forState:UIControlStateNormal];
            
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - lazy load --

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont fontWithName:fFont size:15.0f];
        _titleLabel.textColor = QICIColorTitle;
    }
    return _titleLabel;
}

- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _codeLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _codeLabel.textColor = QICIColorTipText;
    }
    return _codeLabel;
}

- (UILabel *)tradeLabel {
    if (!_tradeLabel) {
        _tradeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tradeLabel.font = [UIFont fontWithName:fFont size:15.0f];
        _tradeLabel.textColor = QICIColorNormalText;
    }
    return _tradeLabel;
}

- (UIButton *)priceChangePercent {
    if (!_priceChangePercent) {
        _priceChangePercent = [[UIButton alloc] initWithFrame:CGRectZero];
        //        _priceChangePercent.backgroundColor = ASDColorBorder;
        _priceChangePercent.layer.cornerRadius = SCALE_Length(5.0f);
        _priceChangePercent.layer.masksToBounds = YES;
        _priceChangePercent.enabled = NO;
        _priceChangePercent.userInteractionEnabled = NO;
        
    }
    return _priceChangePercent;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = QICIColorSeparator;
    }
    return _lineView;
}

@end
