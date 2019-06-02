//
//  TheMarktOthersTableViewCell.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktOthersTableViewCell.h"

#define LeftViewColor RGBColor(188, 140, 255)
#define RightViewColor RGBColor(253, 180, 134)

@implementation TheMarktOthersTableViewCell

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

-(UIView *)leftBackView{
    
    if (!_leftBackView) {
        _leftBackView = [[UIView alloc] init];
        _leftBackView.backgroundColor = LeftViewColor;
        _leftBackView.layer.cornerRadius = 7;
        _leftBackView.layer.shadowColor = LeftViewColor.CGColor;
        _leftBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _leftBackView.layer.shadowRadius = 5;
        _leftBackView.layer.shadowOpacity = 0.7;
        _leftBackView.layer.masksToBounds = NO;
    }
    return _leftBackView;
}

-(UIView *)rightBackView{
    
    if (!_rightBackView) {
        _rightBackView = [[UIView alloc] init];
        _rightBackView.backgroundColor = RightViewColor;
        _rightBackView.layer.cornerRadius = 7;
        _rightBackView.layer.shadowColor = RightViewColor.CGColor;
        _rightBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _rightBackView.layer.shadowRadius = 5;
        _rightBackView.layer.shadowOpacity = 0.7;
        _rightBackView.layer.masksToBounds = NO;
    }
    return _rightBackView;
}

-(UILabel *)leftTitleLabel{
    
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.text = @"期货交易规则";
        _leftTitleLabel.textColor = [UIColor whiteColor];
        _leftTitleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    }
    return _leftTitleLabel;
}

-(UILabel *)rightTitleLabel{
    
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.text = @"财经日历";
        _rightTitleLabel.textColor = [UIColor whiteColor];
        _rightTitleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    }
    return _rightTitleLabel;
}

-(UILabel *)leftInfoLabel{
    
    if (!_leftInfoLabel) {
        _leftInfoLabel = [[UILabel alloc] init];
        _leftInfoLabel.text = @"每日更新交易规则";
        _leftInfoLabel.textColor = [UIColor whiteColor];
        _leftInfoLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    return _leftInfoLabel;
}

-(UILabel *)rightInfoLabel{
    
    if (!_rightInfoLabel) {
        _rightInfoLabel = [[UILabel alloc] init];
        _rightInfoLabel.text = @"懂你所想";
        _rightInfoLabel.textColor = [UIColor whiteColor];
        _rightInfoLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    return _rightInfoLabel;
}

-(UIButton *)leftBtn{
    
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"看一下" forState:UIControlStateNormal];
        _leftBtn.backgroundColor = [UIColor whiteColor];
        [_leftBtn setTitleColor:LeftViewColor forState:UIControlStateNormal];
        _leftBtn.tag = 23456;
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        [_leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setRadius:15 borderWidth:0 borderColor:nil];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"看一下" forState:UIControlStateNormal];
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn setTitleColor:RightViewColor forState:UIControlStateNormal];
        _rightBtn.tag = 23457;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        [_rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setRadius:15 borderWidth:0 borderColor:nil];
    }
    return _rightBtn;
}

-(void)configUI{
    
    [self.contentView addSubview:self.leftBackView];
    [self.contentView addSubview:self.rightBackView];
    
    [self.leftBackView addSubview:self.leftTitleLabel];
    [self.leftBackView addSubview:self.leftInfoLabel];
    [self.leftBackView addSubview:self.leftBtn];
    
    [self.rightBackView addSubview:self.rightTitleLabel];
    [self.rightBackView addSubview:self.rightInfoLabel];
    [self.rightBackView addSubview:self.rightBtn];
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.othersBtnClickBlock) {
        self.othersBtnClickBlock(btn.tag - 23455);
    }
}

-(void)layoutSubviews{
    
    [self.leftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.right.mas_equalTo(self.rightBackView.mas_left).mas_offset(-20);
        make.width.mas_equalTo(self.rightBackView);
    }];
    
    [self.rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.left.mas_equalTo(self.leftBackView.mas_right).mas_offset(20);
        make.width.mas_equalTo(self.leftBackView);
//        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftBackView).mas_offset(10);
        make.top.mas_equalTo(self.leftBackView).mas_offset(10);
    }];
    
    [self.leftInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftBackView).mas_offset(20);
        make.top.mas_equalTo(self.leftTitleLabel.mas_bottom).mas_offset(15);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.leftBackView).mas_offset(-15);
        make.bottom.mas_equalTo(self.leftBackView).mas_offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightBackView).mas_offset(10);
        make.top.mas_equalTo(self.rightBackView).mas_offset(10);
    }];
    
    [self.rightInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightBackView).mas_offset(20);
        make.top.mas_equalTo(self.rightTitleLabel.mas_bottom).mas_offset(15);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightBackView).mas_offset(-15);
        make.bottom.mas_equalTo(self.rightBackView).mas_offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
}

@end
