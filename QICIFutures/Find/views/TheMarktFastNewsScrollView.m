//
//  TheMarktFastNewsScrollView.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktFastNewsScrollView.h"

@implementation TheMarktFastNewsScrollView

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self configUI];
    }
    return self;
}

-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
-(UILabel *)infoLabel{
    
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = [UIFont systemFontOfSize:15];
        _infoLabel.text = @"快讯";
        _infoLabel.textColor = [UIColor redColor];
    }
    return _infoLabel;
}

-(TheMarktRequestViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[TheMarktRequestViewModel alloc] init];
    }
    return _viewModel;
}

-(void)configUI{
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.infoLabel];
    [self requestData];
}

-(void)layoutSubviews{
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView);
        make.centerY.mas_equalTo(self.scrollView);
//        make.height.mas_equalTo(25);
    }];
}

-(void)requestData{
    
    weakSelf(weakSelf);
    [self.viewModel requestFastNewsSuccess:^(NSString * _Nonnull resultString) {
        [weakSelf configInfos:resultString];
    } failture:^(NSString * _Nonnull error) {
        
    }];
}

-(void)configInfos:(NSString *)info{

    CGFloat width = [TheMarktTools widthWithString:info withheight:self.height withFontSize:15];
    self.infoLabel.text = info;
    self.infoLabel.width = width;

    self.scrollView.contentSize = CGSizeMake(width-100, 0);
    
//    [self scrolledScrollview:width];
    [self startScroll];
}

-(void)scrolledScrollview:(CGFloat)width{
    
//    [self.scrollView setContentOffset:CGPointMake(width-100, 0) animated:YES];
    
    [UIView animateWithDuration:50 animations:^{
        self.scrollView.contentOffset = CGPointMake(width-100, 0);
    } completion:^(BOOL finished) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        [self scrolledScrollview:width];
    }];
}

-(void)startScroll{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
}

-(void)autoScroll{
    
    if (self.scrollView.contentOffset.x > self.scrollView.contentSize.width-100) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }else{
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+15, 0) animated:YES];
    }
}

-(void)dealloc{
    
    [self.timer invalidate];
    
    self.timer = nil;
}

@end
