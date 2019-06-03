//
//  MArketTableViewCell.m
//  QICIFutures
//
//  Created by mac on 2019/5/31.
//

#import "MArketTableViewCell.h"
#import "QICIMarkeModel.h"

@interface MArketTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;//产品名

@property (strong, nonatomic) UILabel *codeLabel;//商品代码

@property (strong, nonatomic) UILabel *tradeLabel;//最新价

@property (strong, nonatomic) UIButton *priceChangePercent;//涨跌幅

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) QICIMarkeModel *model;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end
@implementation MArketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.codeLabel];
        [self.contentView addSubview:self.tradeLabel];
        [self.contentView addSubview:self.priceChangePercent];
        [self.contentView addSubview:self.lineView];
        [self configFrames];
    }
    return self;
}

-(void)configFrames{
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



-(void)updataWithMarketModel:(QICIMarkeModel *)model indexPath:(NSIndexPath *)index{
    
    if (model) {
        self.model = model;
    }
    if (index) {
        self.indexPath = index;
    }
    [self loadData];
    
}

-(void)loadData{
    
    if (self.model) {
        self.titleLabel.text = self.model.prod_name;
        self.codeLabel.text = self.model.prod_code;
        self.tradeLabel.text = [NSString gl_fixNumString:[NSString stringWithFormat:@"%@",self.model.last_px] minDecimalsLimit:2 maxDecimalsLimit:2];
        NSString *percent = [NSString gl_fixNumString:[NSString stringWithFormat:@"%@",self.model.px_change_rate] minDecimalsLimit:2 maxDecimalsLimit:2];
        [self.priceChangePercent setTitle:[NSString stringWithFormat:@"%@%%",percent] forState:UIControlStateNormal];
        NSDecimalNumber *change = [self.model.px_change_rate gl_digitalValue];
        NSComparisonResult result = [change compare:@(0)];
        
        if (result == NSOrderedAscending) {
            // 小于0
            [self.priceChangePercent setTitleColor:QICIColorShort forState:UIControlStateNormal];
           
        }else if(result == NSOrderedDescending){
            // 大于0
            [self.priceChangePercent setTitleColor:QICIColorLong forState:UIControlStateNormal];
        }else {
            [self.priceChangePercent setTitleColor:QICIColorBorder forState:UIControlStateNormal];
        }
    }
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
        _lineView.backgroundColor =QICIColorSeparator;
    }
    return _lineView;
}

@end
