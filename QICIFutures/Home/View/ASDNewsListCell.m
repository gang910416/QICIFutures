//
//  ASDNewsListCell.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/29.
//  Copyright © 2019 ASD. All rights reserved.
//

#import "ASDNewsListCell.h"
#import "ASDNewsListModel.h"

@interface ASDNewsListCell ()

/** model */
@property (strong, nonatomic) ASDNewsListModel *newsModel;

/** image */
@property (strong, nonatomic) UIImageView *picView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *timeLabel;

/** lineView */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation ASDNewsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self cell_wrfg:@[@"2",@"3"]  string:@"qwert" num:@(0)];
        
        
        [self p_setUpUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)p_setUpUI {
    
    [self.contentView addSubview:self.picView];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.lineView];
    
    [self p_layout];
}

- (void)p_layout {
    
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(SCALE_Length(- 10.0f));
        make.centerY.equalTo(self.contentView.mas_centerY).offset(SCALE_Length(- 5.0f));
        make.size.mas_equalTo(CGSizeMake(SCALE_Length(60.0f), SCALE_Length(45.0f)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(10.0f));
        make.right.equalTo(self.picView.mas_left).offset(SCALE_Length(- 20.0f));
        make.top.equalTo(self.picView.mas_top);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_Length(5.0f));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(SCALE_Length(10.0f));
    }];
}


- (void)updateDataWithModel:(ASDNewsListModel *)model {
    if(model) {
        self.newsModel = model;
        
        [self.picView sd_setImageWithURL:[NSURL URLWithString:self.newsModel.imgsrc1] placeholderImage:[UIImage imageNamed:@"placeHolder_stock"]];
        [self.titleLabel setText:self.newsModel.title];
        [self.timeLabel setText:self.newsModel.time];
    }
}

-(UIImageView *)picView {
    if (!_picView) {
        _picView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeHolder_stock"]];
        _picView.contentMode = UIViewContentModeScaleAspectFill;
        _picView.layer.cornerRadius = SCALE_Length(5.0f);
        _picView.layer.borderColor = QICIColorBorder.CGColor;
        _picView.layer.borderWidth = 0.5f;
        _picView.layer.masksToBounds = YES;
    }
    return _picView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont fontWithName:fFont size:15.0f];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = QICIColorTitle;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"--";
        
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _timeLabel.textColor = QICIColorNormalText;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"--";
    }
    return _timeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = QICIColorGap;
    }
    return _lineView;
}
@end
