//
//  TheMarktScrollNewsTableViewCell.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktScrollNewsTableViewCell.h"

@implementation TheMarktScrollNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 60)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 8;
        _backView.layer.shadowColor = [UIColor darkTextColor].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, 0);
        _backView.layer.shadowRadius = 5;
        _backView.layer.shadowOpacity = 0.3;
        _backView.layer.masksToBounds = NO;
    }
    return _backView;
}

-(UILabel *)infoLabel{
    
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textColor = [UIColor darkGrayColor];
        _infoLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
        _infoLabel.text = @"time24快讯";
    }
    return _infoLabel;
}

-(UIImageView *)infoImageView{
    
    if (!_infoImageView) {
        _infoImageView = [[UIImageView alloc] init];
        [_infoImageView setImage:imageWithName(@"theMarkt_Flash")];
    }
    return _infoImageView;
}

-(TheMarktFastNewsScrollView *)fastNewsView{
    
    if (!_fastNewsView) {
        _fastNewsView = [[TheMarktFastNewsScrollView alloc] init];
    }
    return _fastNewsView;
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
    
    [self.backView addSubview:self.infoImageView];
    [self.backView addSubview:self.infoLabel];
    [self.backView addSubview:self.fastNewsView];
}

-(void)layoutSubviews{
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(10);
        make.bottom.mas_equalTo(self.backView).mas_offset(-10);
    }];
    
    [self.infoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.backView).mas_offset(15);
        make.centerX.mas_equalTo(self.infoLabel);
        make.top.mas_equalTo(self.backView).mas_offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.fastNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).mas_offset(-15);
        make.top.mas_equalTo(self.backView).mas_offset(10);
        make.bottom.mas_equalTo(self.backView).mas_offset(-10);
        make.left.mas_equalTo(self.infoLabel.mas_right).mas_offset(10);
    }];
}


@end
