

#import "QICIMarketDetailView.h"

@interface QICIMarketDetailView ()

@property(strong, nonatomic) QICIMarkeModel *marketModel;

@property (strong, nonatomic) NSDictionary *keyAttributes;

@property (strong, nonatomic) NSDictionary *valueAttributes;
/** 详细信息的集合 */
@property (strong, nonatomic) NSArray *infoDictArray;

@end

@implementation QICIMarketDetailView


- (instancetype)initWithFrame:(CGRect)frame marketModel:(QICIMarkeModel *)marketModel {

    if (self = [super initWithFrame:frame]) {

        if (marketModel) {
            self.marketModel = marketModel;
        }
        

        [self p_setUpUI];

    }
    return self;
}

- (void)p_setUpUI {

}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [NSObject gl_drawTextArrayWithCtx:ctx rect:CGRectMake(rect.origin.x + SCALE_Length(10.0f) , rect.origin.y + SCALE_Length(20.0f), rect.size.width - SCALE_Length(20.0f), SCALE_Length(60.0f)) listCount:2 verticalGap:SCALE_Length(20) defaultKeyAttributes:self.keyAttributes defaultValueAttributes:self.valueAttributes customKeyAttributes:nil customValueAttributes:@{@"0":@{NSForegroundColorAttributeName:QICIColorShort},@"1":@{NSForegroundColorAttributeName:QICIColorLong}} textArray:@[@{@"委卖档位":self.marketModel.offer_grp},@{@"委买档位":self.marketModel.bid_grp}]];

    [NSObject gl_drawSeparatorLineWithCtx:ctx inRect:CGRectMake(rect.origin.x + SCALE_Length(10.0f), rect.origin.y + SCALE_Length(20.0f), rect.size.width - SCALE_Length(20.0f), SCALE_Length(50.0f)) lineHeight:1.0f separatorColor:QICIColorSeparator];

    UIColor *changColor = QICIColorNormalText;
    
    if ([self.marketModel.px_change_rate doubleValue] > 0) {
        changColor = QICIColorLong;
    }else if([self.marketModel.px_change_rate doubleValue] < 0) {
        changColor = QICIColorShort;
    }
    
    [NSObject gl_drawTextArrayWithCtx:ctx rect:CGRectMake(rect.origin.x, rect.origin.y + SCALE_Length(90.0f), rect.size.width - SCALE_Length(20.0f), rect.size.height - SCALE_Length(90.0f)) listCount:3 verticalGap:SCALE_Length(20) defaultKeyAttributes:self.keyAttributes defaultValueAttributes:self.valueAttributes customKeyAttributes:@{@"4":@{NSForegroundColorAttributeName:changColor},@"5":@{NSForegroundColorAttributeName:changColor}} customValueAttributes:@{@"4":@{NSForegroundColorAttributeName:changColor},@"5":@{NSForegroundColorAttributeName:changColor}} textArray:self.infoDictArray];
}



#pragma mark - 懒加载 --

- (NSDictionary *)keyAttributes {
    if (!_keyAttributes) {
        NSMutableParagraphStyle *centerAlignment = [[NSMutableParagraphStyle alloc] init];
        [centerAlignment setAlignment:NSTextAlignmentCenter];
        
        _keyAttributes = @{NSFontAttributeName:[UIFont kk_systemFontOfSize:15.0f],NSForegroundColorAttributeName:QICIColorTitle,NSParagraphStyleAttributeName:centerAlignment};
    }
    return _keyAttributes;
}

- (NSDictionary *)valueAttributes {
    
    if (!_valueAttributes) {
        NSMutableParagraphStyle *centerAlignment = [[NSMutableParagraphStyle alloc] init];
        [centerAlignment setAlignment:NSTextAlignmentCenter];
        _valueAttributes = @{NSFontAttributeName:[UIFont kk_systemFontOfSize:12.0f],NSForegroundColorAttributeName:QICIColorNormalText,NSParagraphStyleAttributeName:centerAlignment};
    }
    return _valueAttributes;
}

- (NSArray *)infoDictArray {
    
    if (!_infoDictArray) {
        _infoDictArray = @[
                           @{@"最新价":[NSString gl_convertToDisplayStringWithOriginNum:self.marketModel.last_px decimalsLimit:2 prefix:@"" suffix:@""]},
                           @{@"昨收价":[NSString gl_convertToDisplayStringWithOriginNum:self.marketModel.preclose_px decimalsLimit:2 prefix:@"" suffix:@""]},
                           @{@"开盘价":[NSString gl_convertToDisplayStringWithOriginNum:self.marketModel.open_px decimalsLimit:2 prefix:@"" suffix:@""]},
                           @{@"交易状态":self.marketModel.tradeState},
                           @{@"涨跌幅":[NSString gl_convertToDisplayStringWithOriginNum:self.marketModel.px_change_rate decimalsLimit:2 prefix:@"" suffix:@"%"]},
                           @{@"涨跌":[NSString gl_convertToDisplayStringWithOriginNum:self.marketModel.px_change decimalsLimit:3 prefix:@"" suffix:@""]}
                           ];
    }
    return _infoDictArray;
}

@end
