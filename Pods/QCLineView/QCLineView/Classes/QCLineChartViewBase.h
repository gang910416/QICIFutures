
#import <UIKit/UIKit.h>
#import "QCViewBase.h"


@protocol QCLineChartViewDelegate <NSObject>

@optional
- (void)chartValueSelected:(QCViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex;
- (void)chartValueNothingSelected:(QCViewBase *)chartView;

- (void)chartKlineScrollLeft:(QCViewBase *)chartView;


@end

@interface QCLineChartViewBase : QCViewBase


@property (nonatomic,assign) CGFloat uperChartHeightScale;
@property (nonatomic,assign) CGFloat xAxisHeitht;

@property (nonatomic,strong) UIColor *gridBackgroundColor;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat borderWidth;


@property (nonatomic,assign)CGFloat maxPrice;
@property (nonatomic,assign)CGFloat minPrice;
@property (nonatomic,assign)CGFloat maxVolume;
@property (nonatomic,assign)CGFloat candleCoordsScale;
@property (nonatomic,assign)CGFloat volumeCoordsScale;

@property (nonatomic,assign)NSInteger highlightLineCurrentIndex;
@property (nonatomic,assign)CGPoint highlightLineCurrentPoint;
@property (nonatomic,assign)BOOL highlightLineCurrentEnabled;

@property (nonatomic,strong)NSDictionary * leftYAxisAttributedDic;
@property (nonatomic,strong)NSDictionary * xAxisAttributedDic;
@property (nonatomic,strong)NSDictionary * highlightAttributedDic;
@property (nonatomic,strong)NSDictionary * defaultAttributedDic;

@property (nonatomic,assign)BOOL highlightLineShowEnabled;
@property (nonatomic,assign)BOOL scrollEnabled;
@property (nonatomic,assign)BOOL zoomEnabled;

@property (nonatomic,assign)BOOL leftYAxisIsInChart;
@property (nonatomic,assign)BOOL rightYAxisDrawEnabled;

@property (nonatomic,assign)id<QCLineChartViewDelegate>  delegate;


@property (nonatomic,assign)BOOL isETF;


- (void)drawline:(CGContextRef)context
      startPoint:(CGPoint)startPoint
       stopPoint:(CGPoint)stopPoint
           color:(UIColor *)color
       lineWidth:(CGFloat)lineWitdth;

- (void)drawLabelPrice:(CGContextRef)context;

//圆点
-(void)drawCiclyPoint:(CGContextRef)context
                point:(CGPoint)point
               radius:(CGFloat)radius
                color:(UIColor*)color;
- (void)drawHighlighted:(CGContextRef)context
                  point:(CGPoint)point
                   idex:(NSInteger)idex
                  value:(id)value
                  color:(UIColor *)color
              lineWidth:(CGFloat)lineWidth;


- (void)drawLabel:(CGContextRef)context
   attributesText:(NSAttributedString *)attributesText
             rect:(CGRect)rect;

- (void)drawRect:(CGContextRef)context
            rect:(CGRect)rect
           color:(UIColor*)color;


- (void)drawGridBackground:(CGContextRef)context
                      rect:(CGRect)rect;



@end
