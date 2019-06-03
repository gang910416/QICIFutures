//
//  StockLineView.m
//  THSGP
//
//  Created by Bingo on 2019/4/1.
//

#import "QCStockLineView.h"
#import "YKLineChart.h"

@interface QCStockLineView()<QCLineChartViewDelegate>

@property (strong, nonatomic)  QCLineChartView *klineView;
@end
@implementation QCStockLineView

-(instancetype)instanceViewWithSize:(CGSize)size;
{
    if ([self init]) {
        self.frame = CGRectMake(0, 0, size.width, size.height);
        
        [self configUi];
    }
    return self;
}

- (void)configUi
{
    

    
    
    self.klineView = [[QCLineChartView alloc] init];
    [self addSubview:self.klineView];
    [self.klineView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
    self.klineView.gridBackgroundColor = [UIColor whiteColor];//格子背景色
    self.klineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];//网格线颜色
    self.klineView.borderWidth = .5;//网格线宽度0.5
    self.klineView.candleWidth = 8;//当天对应线的宽度
    self.klineView.candleMaxWidth = 30;//最大宽度
    self.klineView.candleMinWidth = 1;//最小宽度
    self.klineView.uperChartHeightScale = 0.7;//超图表高度比例
    self.klineView.xAxisHeitht = 25;
    self.klineView.delegate = self;
    self.klineView.highlightLineShowEnabled = YES;
    self.klineView.zoomEnabled = YES;
    self.klineView.scrollEnabled = YES;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.klineView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
   
}

-(void)reloadData:(NSArray *)data
{
    
    NSMutableArray * timeArray = [NSMutableArray array];
        for (NSDictionary * info in data) {
            QCLineEntity * entity = [[QCLineEntity alloc]init];
            
            entity.high = [[info objectForKey:@"high"] doubleValue];//最高价
            entity.open = [[info objectForKey:@"open"] doubleValue];//开盘价
            entity.low = [[info objectForKey:@"low"] doubleValue];//最低价
            
            entity.close = [[info objectForKey:@"close"] doubleValue];//收盘价
            entity.date = [NSString stringWithFormat:@"%@",[info objectForKey:@"date"]] ;
            entity.ma5 = [[info objectForKey:@"ma5"] doubleValue];
            entity.ma10 = [[info objectForKey:@"ma10"] doubleValue];
            entity.ma20 = [[info objectForKey:@"ma20"] doubleValue];
            entity.volume = [[info objectForKey:@"volume"]  doubleValue];

            
            [timeArray addObject:entity];
        }
    
    [timeArray addObjectsFromArray:timeArray];
    QCLineDataSet * dataset = [[QCLineDataSet alloc]init];
    dataset.data = timeArray;
    dataset.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
    dataset.highlightLineWidth = 0.7;
    dataset.candleRiseColor = [UIColor colorWithRed:233/255.0 green:47/255.0 blue:68/255.0 alpha:1.0];
    dataset.candleFallColor = [UIColor colorWithRed:33/255.0 green:179/255.0 blue:77/255.0 alpha:1.0];
    dataset.avgLineWidth = 1.f;
    dataset.avgMA10Color = [UIColor colorWithRed:252/255.0 green:85/255.0 blue:198/255.0 alpha:1.0];
    dataset.avgMA5Color = [UIColor colorWithRed:67/255.0 green:85/255.0 blue:109/255.0 alpha:1.0];
    dataset.avgMA20Color = [UIColor colorWithRed:216/255.0 green:192/255.0 blue:44/255.0 alpha:1.0];
    dataset.candleTopBottmLineWidth = 1;
    

    [self.klineView setupData:dataset];
    

}

@end
