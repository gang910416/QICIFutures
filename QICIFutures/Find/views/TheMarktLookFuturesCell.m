//
//  TheMarktLookFuturesCell.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktLookFuturesCell.h"

@implementation TheMarktLookFuturesCell

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
        _titleInfoLabel.textColor = [UIColor whiteColor];
        _titleInfoLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    }
    
    return _titleInfoLabel;
}

-(UILabel *)bodyInfoLabel{
    
    if (!_bodyInfoLabel) {
        _bodyInfoLabel = [[UILabel alloc] init];
        
        _bodyInfoLabel.textColor = [UIColor whiteColor];
        _bodyInfoLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bodyInfoLabel;
}

-(UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 50)];
        
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
    [self.backView addSubview:self.bodyInfoLabel];
    
}

-(void)layoutSubviews{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    
    [self.titleInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(20);
        make.bottom.mas_equalTo(self.backView.mas_centerY);
    }];
    
    [self.bodyInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(20);
        make.top.mas_equalTo(self.backView.mas_centerY).mas_offset(7);
    }];
    
    self.backView.layer.shadowOffset = CGSizeMake(0, 0);
    self.backView.layer.cornerRadius = 25;
    self.backView.layer.masksToBounds = NO;
    self.backView.layer.shadowOpacity = 0.7;
    self.backView.layer.shadowRadius = 5;
    
}

-(void)buildWithTitle:(NSString *)title body:(NSString *)body backColor:(nonnull UIColor *)color{
    
    self.titleInfoLabel.text = title;
    self.bodyInfoLabel.text = body;
    self.backView.backgroundColor = color;
    self.backView.layer.shadowColor = color.CGColor;
}

@end
