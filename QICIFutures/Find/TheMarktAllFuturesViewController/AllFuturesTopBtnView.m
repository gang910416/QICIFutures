//
//  AllFuturesTopBtnView.m
//  QCLC
//
//  Created by mac on 2019/5/24.
//

#import "AllFuturesTopBtnView.h"

@implementation AllFuturesTopBtnView

-(instancetype)initWithFrame:(CGRect)frame andBtns:(NSArray *)btnArray{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.btnArray removeAllObjects];
        [self.btnArray addObjectsFromArray:btnArray];
        [self configUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

-(NSMutableArray *)btnArray{
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(void)configUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < self.btnArray.count; i ++) {
        
        NSString *title = self.btnArray[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:MarktGlobalColor forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = MarktGlobalColor.CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 234+[self.btnArray indexOfObject:title];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        float a = self.width/self.btnArray.count-15;
        
        if (a > 300) {
            a = 60;
        }
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(7.5+i*(a+15));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(a);
            make.height.mas_equalTo(self.height/3*2);
        }];
    }
    
}

-(void)btnClick:(UIButton *)btn{
    
    if (!btn.selected) {
        btn.selected = YES;
        [btn setBackgroundColor:MarktGlobalColor];
        
        for (int a = 0; a < self.btnArray.count; a ++) {
            if (a != btn.tag - 234) {
                UIButton *tempBtn = (UIButton *)[self viewWithTag:234+a];
                [tempBtn setBackgroundColor:[UIColor whiteColor]];
                tempBtn.selected = NO;
            }
        }
        if (self.btnClickBlock) {
            self.btnClickBlock(btn.tag-234);
        }
    }
}

-(void)selectIndex:(NSInteger)i{
    
    UIButton *btn = (UIButton *)[self viewWithTag:234+i];
    btn.selected = YES;
    [btn setBackgroundColor:MarktGlobalColor];
    
    for (int a = 0; a < self.btnArray.count; a ++) {
        if (a != i) {
            UIButton *tempBtn = (UIButton *)[self viewWithTag:234+a];
            [tempBtn setBackgroundColor:[UIColor whiteColor]];
            tempBtn.selected = NO;
        }
    }
}

-(void)refreshWithArray:(NSArray *)array{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self.btnArray removeAllObjects];
    [self.btnArray addObjectsFromArray:array];
    
    [self configUI];
}

@end
