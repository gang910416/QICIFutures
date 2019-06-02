//
//  TheMarktLearnsTableViewCell.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktLearnsTableViewCell.h"

@implementation TheMarktLearnsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)info1Label{
    
    if (!_info1Label) {
        _info1Label = [[UILabel alloc] init];
        _info1Label.text = @"∙ 不了解什么是期货?";
        _info1Label.textColor = [UIColor whiteColor];
        _info1Label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    return _info1Label;
}

-(UILabel *)info2Label{
    
    if (!_info2Label) {
        _info2Label = [[UILabel alloc] init];
        _info2Label.text = @"∙ 想学习进阶知识?";
        _info2Label.textColor = [UIColor whiteColor];
        _info2Label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    return _info2Label;
}

-(UILabel *)info3Label{
    
    if (!_info3Label) {
        _info3Label = [[UILabel alloc] init];
        _info3Label.text = @"∙ 想看大神指导?";
        _info3Label.textColor = [UIColor whiteColor];
        _info3Label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    return _info3Label;
}

-(UILabel *)titleInfoLabel{
    
    if (!_titleInfoLabel) {
        _titleInfoLabel = [[UILabel alloc] init];
        _titleInfoLabel.text = @"新人讲堂";
        _titleInfoLabel.textColor = [UIColor whiteColor];
        _titleInfoLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    }
    return _titleInfoLabel;
}

-(UIImageView *)infoImageView{
    
    if (!_infoImageView) {
        _infoImageView = [[UIImageView alloc] init];
        [_infoImageView setImage:imageWithName(@"")];
    }
    return _infoImageView;
}
-(UIButton *)seeBtn{
    
    if (!_seeBtn) {
        _seeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeBtn setTitle:@"查看" forState:UIControlStateNormal];
        _seeBtn.backgroundColor = [UIColor whiteColor];
        [_seeBtn setTitleColor:RGBColor(40, 192, 255) forState:UIControlStateNormal];
        _seeBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightHeavy];
        [_seeBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_seeBtn setRadius:15 borderWidth:0 borderColor:nil];
    }
    return _seeBtn;
}

-(UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGBColor(40, 192, 255);
        _backView.layer.cornerRadius = 8;
        _backView.layer.shadowColor = RGBColor(40, 192, 255).CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, 0);
        _backView.layer.shadowRadius = 5;
        _backView.layer.shadowOpacity = 0.7;
        _backView.layer.masksToBounds = NO;
    }
    return _backView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self configUI];
    }
    
    return self;
}

-(void)configUI{
    
    [self.contentView addSubview:self.backView];
    
    [self.backView addSubview:self.titleInfoLabel];
    [self.backView addSubview:self.info1Label];
    [self.backView addSubview:self.info2Label];
    [self.backView addSubview:self.info3Label];
    [self.backView addSubview:self.seeBtn];
    
}

-(void)layoutSubviews{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    
    [self.titleInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(10);
        make.top.mas_equalTo(self.backView).mas_offset(10);
    }];
    
    [self.info1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(25);
        make.top.mas_equalTo(self.titleInfoLabel).mas_offset(30);
    }];
    
    [self.info2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(25);
        make.top.mas_equalTo(self.info1Label).mas_offset(20);
    }];
    
    [self.info3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(25);
        make.top.mas_equalTo(self.info2Label).mas_offset(20);
    }];
    
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).mas_offset(-20);
        make.bottom.mas_equalTo(self.backView).mas_offset(-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
}

-(void)seeBtnClick:(UIButton *)btn{
    
    if (self.jumpToLearnView) {
        self.jumpToLearnView();
    }
}

@end
