//
//  QCBtnSView.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "QCBtnSView.h"
#import "MCButton.h"
@interface QCBtnSView ()

/** titles */
@property (strong, nonatomic) NSArray *titles;

/** imgs */
@property (strong, nonatomic) NSArray <NSString *>*icons;

/** Btns */
@property (strong, nonatomic) NSMutableArray *btns;

@property (strong, nonatomic) UIView *backView;

@end
#define kBtnWidth (kDeviceWidth / 4.0f)
#define kBaseTag (678)

@implementation QCBtnSView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles icons:(NSArray *)icons {
    
    if (self = [super initWithFrame:frame]) {
        
        if (titles) {
            self.titles = titles;
        }
        
        if (icons) {
            self.icons = icons;
        }
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    [self addSubview:self.backView];
    
    [self setBtns];
    
    [self layoutBtnFrame];
    
}

- (void)setBtns {
    
    if(self.titles && self.titles.count > 0){
        
        for (int i = 0; i < self.titles.count; i ++) {
            NSString *iconName = [self.icons objectAtIndex:i];
            
//            JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
//            config.styleType = JMButtonStyleTypeTop;
//            config.imageSize = CGSizeMake(SCALE_Length(25.0f), SCALE_Length(25.0f));
//            config.padding = SCALE_Length(3.0f);
//            config.image = [UIImage imageNamed:iconName];
//            config.titleColor = QICIColorTitle;
//            config.title = [self.titles objectAtIndex:i];
//            config.titleFont = [UIFont fontWithName:fFont size:SCALE_Length(12.0f)];
//            MCButton *btn = [MCButton buttonFrame:CGRectMake(kBtnWidth * (i % 4),(i / 4) * SCALE_Length(60.0f) + SCALE_Length(20.0f), kBtnWidth, SCALE_Length(40.0f)) ButtonConfig:config];
//            [btn addTarget:self action:@selector(p_subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            btn.tag = kBaseTag + i;
            
           MCButton  *toolBtn= [MCButton buttonWithType:UIButtonTypeCustom];
            toolBtn.buttonStyle = imageTop;
            //        [toolBtn setBackgroundColor: [UIColor whiteColor]];
            [toolBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
            [toolBtn setTitle:self.titles[i] forState:UIControlStateNormal];
            toolBtn.titleLabel.font = [UIFont systemFontOfSize:13];
             toolBtn.tag = kBaseTag + i;
            [toolBtn addTarget:self action:@selector(p_subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [toolBtn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
            //        [toolBtn setBackgroundColor:[UIColor redColor]];
            toolBtn.frame =CGRectMake(kBtnWidth * (i % 4),(i / 4) * SCALE_Length(60.0f) + SCALE_Length(20.0f), kBtnWidth, SCALE_Length(40.0f));
            [self.backView addSubview:toolBtn];
        }
    }
}

- (void)layoutBtnFrame {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(SCALE_Length(- 10.0f));
    }];
}

- (void)p_subBtnAction:(UIButton *)btn {
    
    if (btn) {
        NSInteger index = btn.tag - kBaseTag;
        
        if (_delegate && [_delegate respondsToSelector:@selector(delegate_touchBtnWithIndex:)]) {
            [_delegate delegate_touchBtnWithIndex:index];
        }
    }
}


- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = @[].mutableCopy;
    }
    return _btns;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = QICIColorBackGround;
    }
    return _backView;
}


@end
