//
//  SearchIResultDataTableViewCell.m
//  QCLC
//
//  Created by mac on 2019/5/27.
//

#import "SearchIResultDataTableViewCell.h"

@implementation SearchIResultDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

-(UILabel *)openLabel{
    
    if (!_openLabel) {
        _openLabel = [[UILabel alloc] init];
        _openLabel.textColor = [UIColor darkGrayColor];
        _openLabel.font = [UIFont systemFontOfSize:11];
    }
    return _openLabel;
}

-(UILabel *)lowLabel{
    
    if (!_lowLabel) {
        _lowLabel = [[UILabel alloc] init];
        _lowLabel.textColor = [UIColor darkGrayColor];
        _lowLabel.font = [UIFont systemFontOfSize:11];
    }
    return _lowLabel;
}

-(UILabel *)highLabel{
    
    if (!_highLabel) {
        _highLabel = [[UILabel alloc] init];
        _highLabel.textColor = [UIColor darkGrayColor];
        _highLabel.font = [UIFont systemFontOfSize:11];
    }
    return _highLabel;
}

-(UILabel *)chicangabel{
    
    if (!_chicangabel) {
        _chicangabel = [[UILabel alloc] init];
        _chicangabel.textColor = [UIColor darkGrayColor];
        _chicangabel.font = [UIFont systemFontOfSize:11];
    }
    return _chicangabel;
}

-(UILabel *)jiesuanLabel{
    
    if (!_jiesuanLabel) {
        _jiesuanLabel = [[UILabel alloc] init];
        _jiesuanLabel.textColor = [UIColor darkGrayColor];
        _jiesuanLabel.font = [UIFont systemFontOfSize:11];
    }
    return _jiesuanLabel;
}

-(UILabel *)rizeLabel{
    
    if (!_rizeLabel) {
        _rizeLabel = [[UILabel alloc] init];
        _rizeLabel.textColor = [UIColor darkGrayColor];
        _rizeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _rizeLabel;
}

-(void)configUI{
    
    [self.contentView addSubview:self.openLabel];
    [self.contentView addSubview:self.highLabel];
    [self.contentView addSubview:self.lowLabel];
    [self.contentView addSubview:self.chicangabel];
    [self.contentView addSubview:self.rizeLabel];
    [self.contentView addSubview:self.jiesuanLabel];
    
    [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    [self.highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    [self.lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    
    [self.chicangabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.openLabel.mas_bottom).mas_offset(20);
    }];
    [self.jiesuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.openLabel.mas_bottom).mas_offset(20);
    }];
    [self.rizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        make.top.mas_equalTo(self.openLabel.mas_bottom).mas_offset(20);
    }];
}

-(void)refreshWithDatas:(NSArray *)array isGuonei:(BOOL)isGuonei{
    
    if(array.count > 0){
        if (array.count <=13) {
            return;
        }
        if (isGuonei) {
            NSString *open = array[2];
            NSString *high = array[3];
            NSString *low = array[4];
            NSString *chicang = array[13];
            NSString *jiesuan = array[9];
            float rize = (jiesuan.floatValue - open.floatValue)/(open.floatValue);
            self.openLabel.text = [NSString stringWithFormat:@"开盘价:%@",open];
            self.highLabel.text = [NSString stringWithFormat:@"最高价:%@",high];
            self.lowLabel.text = [NSString stringWithFormat:@"最低价:%@",low];
            self.chicangabel.text = [NSString stringWithFormat:@"持仓量:%@",chicang];
            self.jiesuanLabel.text = [NSString stringWithFormat:@"结算价:%@",jiesuan];
            self.rizeLabel.text = [NSString stringWithFormat:@"涨跌:%.4f",rize];
        }else{
            if (array.count <=9) {
                return;
            }
            NSString *open = array[8];
            NSString *high = array[4];
            NSString *low = array[5];
            NSString *chicang = array[9];
            NSString *jiesuan = array[0];
            NSString *rize = array[1];
            self.openLabel.text = [NSString stringWithFormat:@"开盘价:%@",open];
            self.highLabel.text = [NSString stringWithFormat:@"最高价:%@",high];
            self.lowLabel.text = [NSString stringWithFormat:@"最低价:%@",low];
            self.chicangabel.text = [NSString stringWithFormat:@"持仓量:%@",chicang];
            self.jiesuanLabel.text = [NSString stringWithFormat:@"结算价:%@",jiesuan];
            self.rizeLabel.text = [NSString stringWithFormat:@"涨跌:%@",rize];
        }
    }
    
}

@end
