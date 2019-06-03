//
//  TheMarktFuturesNewsTableViewCell.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "TheMarktFuturesNewsTableViewCell.h"

@implementation TheMarktFuturesNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)titleInfoLabel{
    
    if (!_titleInfoLabel) {
        _titleInfoLabel = [[UILabel alloc] init];
        _titleInfoLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        _titleInfoLabel.textColor = [UIColor darkTextColor];
    }
    return _titleInfoLabel;
}

-(UILabel *)bodyInfoLabel{
    
    if (!_bodyInfoLabel) {
        _bodyInfoLabel = [[UILabel alloc] init];
        _bodyInfoLabel.numberOfLines = 0;
        _bodyInfoLabel.font = [UIFont systemFontOfSize:12];
        _bodyInfoLabel.textColor = [UIColor darkTextColor];
    }
    return _bodyInfoLabel;
}

-(UILabel *)timeInfoLabel{
    
    if (!_timeInfoLabel) {
        _timeInfoLabel = [[UILabel alloc] init];
        _timeInfoLabel.font = [UIFont systemFontOfSize:10];
        _timeInfoLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeInfoLabel;
}

-(UIImageView *)newsImage{
    
    if (!_newsImage) {
        _newsImage = [[UIImageView alloc] init];
        [_newsImage setRadius:8 borderWidth:0 borderColor:nil];
    }
    
    return _newsImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

-(void)layoutSubviews{
    
    [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.width.mas_equalTo(self.newsImage.mas_height).multipliedBy(1.5);
    }];
    
    [self.titleInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.newsImage.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
    }];
    
    [self.bodyInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleInfoLabel);
        make.top.mas_equalTo(self.titleInfoLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.titleInfoLabel);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-30);
    }];
    
    [self.timeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-5);
        make.top.mas_equalTo(self.bodyInfoLabel.mas_bottom).mas_offset(10);
    }];
}

-(void)configUI{
    
    [self.contentView addSubview:self.titleInfoLabel];
    [self.contentView addSubview:self.bodyInfoLabel];
    [self.contentView addSubview:self.timeInfoLabel];
    [self.contentView addSubview:self.newsImage];
}

-(void)buildWihtModel:(TheMarktNewsModel *)model{
    
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:imageWithName(@"TheMarkt_newsDefault")];
    self.titleInfoLabel.text = model.title;
    self.bodyInfoLabel.text = model.descriptionInfo;
    self.timeInfoLabel.text = model.publishDate;
    
//    [self layoutSubviews];
}

@end
