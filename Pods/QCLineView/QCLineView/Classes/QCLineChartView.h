
#import "QCLineChartViewBase.h"

@class  QCLineDataSet;
@interface QCLineChartView : QCLineChartViewBase


@property (nonatomic,assign)CGFloat candleWidth;
@property (nonatomic,assign)CGFloat candleMaxWidth;
@property (nonatomic,assign)CGFloat candleMinWidth;

@property (nonatomic,assign)BOOL isShowAvgMarkerEnabled;

@property (nonatomic,strong)NSDictionary * avgLabelAttributedDic;


- (void)setupData:(QCLineDataSet *)dataSet;

- (void)addDataSetWithArray:(NSArray *)array;
@end
