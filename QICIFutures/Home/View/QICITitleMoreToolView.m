

#import "QICITitleMoreToolView.h"

@interface QICITitleMoreToolView ()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *moreBtn;

@property (readwrite, strong, nonatomic, nonnull) NSString *titleString;

@property (readwrite, strong, nonatomic, nullable) NSString *moreBtnTitle;

@property (strong, nonatomic) UIImageView *moreImg;

@property (strong, nonatomic) UIView *headerView;
@end

@implementation QICITitleMoreToolView

- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString * _Nullable)titleString moreBtnTitle:(NSString * _Nullable)moreBtnString {
    
    if (self = [super initWithFrame:frame]) {
        
        if (!isStrEmpty(titleString)) {
            self.titleString = titleString;
        }
        
        if (!isStrEmpty(moreBtnString)) {
            self.moreBtnTitle = moreBtnString;
        }

        
        [self p_asd_configUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        if (isStrEmpty(self.titleString)) {
            self.titleString = @"title";
        }
        
        [self p_asd_configUI];
    }
    return self;
}


- (void)p_asd_configUI {
    
    [self addSubview:self.headerView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreBtn];
    [self addSubview:self.moreImg];
    
    [self p_layout];
}

- (void)p_layout {
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(10.0f));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SCALE_Length(3.0f), SCALE_Length(20.0f)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(20.0f));
        make.right.equalTo(self.mas_right).offset(- SCALE_Length(100.0f));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(- SCALE_Length(10.0f));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20.0f,20.0f));
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.moreImg.mas_left).offset(SCALE_Length(- 5.0f));
        make.centerY.equalTo(self.mas_centerY);
    }];

}

- (void)p_moreBtnAction:(UIButton *)moreBtn {
    
    if (_delegate && [_delegate respondsToSelector:@selector(titleMoreToolView:didSelectedMoreBtn:)]) {
        [_delegate titleMoreToolView:self didSelectedMoreBtn:moreBtn];
    }
}

#pragma mark - 公共方法 ---


- (void)updateTitleString:(NSString * _Nullable)titleString moreBtnString:(NSString *_Nullable)moreBtnString {
    
    if (isStrEmpty(titleString)) {
        self.titleString = @"";
    }else {
        self.titleString = titleString;
    }
    
    if (isStrEmpty(moreBtnString)) {
        self.moreBtnTitle = @"";
    }else {
        self.moreBtnTitle = moreBtnString;
    }
    
    [self.titleLabel setText:self.titleString];
    [self.moreBtn setTitle:self.moreBtnTitle forState:UIControlStateNormal];
}

#pragma mark - lazy load --

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        _titleLabel.textColor =QICIColorTitle;
        _titleLabel.text = self.titleString;
    }
    return _titleLabel;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        if (!isStrEmpty(self.moreBtnTitle)) {
            [_moreBtn setTitle:self.moreBtnTitle forState:UIControlStateNormal];
        }
        _moreBtn.titleLabel.font = [UIFont fontWithName:fFont size:15.0f];
        [_moreBtn setTitleColor:QICIColorTipText forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(p_moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (UIImageView *)moreImg {
    if (!_moreImg) {
        _moreImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_more"]];
        _moreImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _moreImg;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCALE_Length(3.0f), SCALE_Length(30.0f))];
        _headerView.backgroundColor = QICIColorTheme;
    }
    return _headerView;
}

@end
