
#import "QCLineChartViewBase.h"
#import "QCLineDataSet.h"

@interface QCTimeLineView : QCLineChartViewBase


@property (nonatomic,assign)CGFloat offsetMaxPrice;
@property (nonatomic,assign)NSInteger countOfTimes;

@property (nonatomic,assign)BOOL endPointShowEnabled;
@property (nonatomic,assign)BOOL isDrawAvgEnabled;

- (void)setupData:(YKTimeDataset *)dataSet;
@end
