//
//  KLineView.m
//  KLineDemo
//
//  Created by kk_ghostlord on 2018/4/28.
//  Copyright © 2018年 Ghostlrod. All rights reserved.
//

#import "ASDKLineView.h"
#import "KLineViewConfig.h"
#import "DataCenter.h"
#import "KLineDataLogic.h"
#import "KLineDrawLogic.h"
#import "KLineBGDrawLogic.h"
#import "KLineVolDrawLogic.h"
#import "KLineMADrawLogic.h"
#import "KLineTimeDrawLogic.h"
#import "KLineVolMADrawLogic.h"
#import "KLineMACDDrawLogic.h"

@interface ASDKLineView ()<DataCenterProtocol,KLineDataLogicProtocol>

/**
 数据中心
 */
@property (readwrite, weak, nonatomic) DataCenter *dataCenter;

/**
 数据逻辑处理类
 */
@property (readwrite, strong, nonatomic) KLineDataLogic *dataLogic;

/**
 K线图的配置对象
 默认为KlineViewConfig
 如果要自定义，请使用initWithConfig:方法
 */
@property (readwrite, strong, nonatomic) NSObject<KLineViewProtocol>*config;

/**
 绘图算法集合
 */
@property (strong, nonatomic) NSMutableArray *drawLogicArray;

/**
 当前显示的图的比例
 */
@property (assign, nonatomic) CGFloat currentScale;

/**
 每个item的宽度
 */
@property (assign, nonatomic) CGFloat perItemWidth;

/**
 当前显示的item范围
 */
@property (assign, nonatomic) CGPoint visibleRange;

/**
 是否在缩放状态
 */
@property (assign, nonatomic) BOOL isPinching;

/**
 当前最大能够显示的K线条数
 */
@property (assign, nonatomic) CGFloat maxItemCount;

/**
 触摸点集合
 只保存前两个触点
 */
@property (strong, nonatomic) NSMutableArray <UITouch *>*touchArray;

/**
 左滑或右滑时的偏移量
 */
@property (assign, nonatomic) CGFloat lastTouchPointX;

/**
 缩放时的两触点距离
 */
@property (assign, nonatomic) CGFloat lastPinchWidth;

/**
 当前的最值
 */
@property (readwrite, assign, nonatomic) GLExtremeValue currentExtremeValue;

/**
 更新最大最小值的block
 */
@property (copy, nonatomic) UpdateExtremeValueBlock updateExtremeValueBlock;

/**
 各绘图算法的最大最小值
 {identifier:@(GLExtremeValue)}
 */
@property (strong, nonatomic) NSMutableDictionary *extremeValueDict;

/**
 是否主动清除所有绘图算法
 */
@property (assign, nonatomic) BOOL isCustomClean;

/**
 是否正在显示十字线
 */
@property (assign, nonatomic) BOOL isShowReticle;

/**
 开始的触点所处的位置
 */
@property (assign, nonatomic) CGPoint beginPoint;

/**
 触摸开始时的时间戳
 */
@property (assign, nonatomic) NSTimeInterval touchBeginStamp;

/**
 是否是第一次添加数据
 */
@property (assign, nonatomic) BOOL isFirstLoad;

/**
 十字线选中的model
 */
@property (strong, nonatomic) KLineModel *selectedModel;

@end

@implementation ASDKLineView

/**
 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 初始化方法
        // 提升性能
        self.layer.drawsAsynchronously = YES;
        // 支持多点触控
        self.multipleTouchEnabled = YES;
        // 第一次添加数据
        self.isFirstLoad = YES;
        // 默认不显示十字线
        self.isShowReticle = NO;
        // 手势开始时间戳
        self.touchBeginStamp = 0.0;
        // 默认不在缩放状态
        self.isPinching = NO;
        // 默认的比例为1.0
        self.currentScale = 1.0f;
        // 默认的一个K线的宽度为实体线的宽度与K线之间的间隙的和
        self.perItemWidth = ([self.config defaultEntityLineWidth] + [self.config klineGap]) * self.currentScale;
        // 默认的最大最小值
        self.currentExtremeValue = GLExtremeValueMake(0.0f, 0.0f);
        // 获得默认的显示区域
        [self visibleRange];
        // 对frame添加观察者
        [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

/**
 初始化方法
 
 @param frame 尺寸
 @param customConfig 自定义配置文件
 */
- (instancetype)initWithFrame:(CGRect)frame config:(NSObject<KLineViewProtocol> * _Nullable)customConfig {
    
    if (self = [super initWithFrame:frame]) {
        
        // 自定义配置文件
        if (customConfig) {
            BOOL isConforms = [customConfig conformsToProtocol:@protocol(KLineViewProtocol)];
            NSAssert(isConforms, @"customConfig must conforms to KLineViewProtocol!");
            if (isConforms) {
                self.config = customConfig;
            }
        }
        
        // 初始化方法
        
    }
    return self;
}

/**
 绘图方法
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 如果绘图算法集合为空，就添加默认的绘图算法
    if (!(self.drawLogicArray && self.drawLogicArray.count >= 1)) {
        
        [self p_addDefaultDrawLogic];
    }
    // 按照绘图算法绘制
    for (BaseDrawLogic *drawLogic in self.drawLogicArray) {
        
        [self drawWithLogic:drawLogic contentext:ctx rect:rect];
    }
}

- (void)dealloc {
    // 移除监听者
    [self removeObserver:self forKeyPath:@"bounds"];
}

#pragma mark - 观察者方法 ----

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // 当视图的bounds有变化时重新计算显示区域
    if ([keyPath isEqualToString:@"bounds"] && [object isEqual:self]) {
        
        [self p_updateVisibleRangeForNewBounds];
    }
    
}

#pragma mark - 公共方法 ---

/**
 将当前View的DataLogic更换为指定的DataLogic
 
 @param dataLogic 指定的dataLogic
 */
- (void)replaceDataLogicWithLogic:(KLineDataLogic *)dataLogic {
    if (dataLogic) {
        _dataLogic = dataLogic;
        [_dataLogic addDelegate:self];
    }
}


/**
 是否包含某个指定id的绘图算法
 
 @param identifier id
 @return 存在返回YES，不存在返回NO
 */
- (BOOL)containsDrawLogicWithIdentifier:(NSString * _Nullable)identifier {
    BOOL isContatin = NO;
    
    if(identifier && [identifier isKindOfClass:[NSString class]]) {
        for (BaseDrawLogic *tempDrawLogic in self.drawLogicArray) {
            if ([tempDrawLogic.drawLogicIdentifier isEqualToString:identifier]) {
                isContatin = YES;
                break;
            }
        }
    }
    return isContatin;
}


/**
 添加绘图算法
 
 @param logic 需要添加的绘图算法
 @return 添加后的绘图算法
 */
- (NSArray <BaseDrawLogic *>* _Nullable)addDrawLogic:(BaseDrawLogic<ChartDrawProtocol>*)logic {
    
    if([logic isMemberOfClass:[KLineBGDrawLogic class]]) {
        // 如果添加背景算法，就先把默认的移除掉
        [self removeDrawLogicWithLogicId:klineBGDrawLogicDefaultIdentifier];
    }
    
    for (BaseDrawLogic *tempLogic in self.drawLogicArray) {
        if (tempLogic.drawLogicIdentifier && [tempLogic.drawLogicIdentifier isEqualToString:logic.drawLogicIdentifier]) {
            return self.drawLogicArray;
        }
    }
    
    logic.config = self.config;
    [self.drawLogicArray addObject:logic];
    
    [self reDrawWithType:ReDrawTypeDefault];
    
    return self.drawLogicArray;
}

/**
 清除所有绘图算法
 
 @return 清除的算法个数
 */
- (NSInteger)removeAllDrawLogic {
    NSInteger count = self.drawLogicArray.count;
    
    [self.drawLogicArray removeAllObjects];
    [self p_removeAllExtremeValues];
    self.isCustomClean = YES;
    [self reDrawWithType:ReDrawTypeDefault];
    return count;
}

/**
 移除某个绘图算法
 
 @param identifier 需要移除的绘图算法的标识符
 @return 移除以后的绘图算法集合
 */
- (NSArray <BaseDrawLogic *>* _Nullable)removeDrawLogicWithLogicId:(NSString *)identifier {
    
    if (!identifier || identifier.length <= 0) {
        
        NSAssert(false, @"drawLogic obj is nil");
        return self.drawLogicArray;
    }
    
    for (BaseDrawLogic *drawLogic in [self.drawLogicArray copy]) {
        if ([drawLogic.drawLogicIdentifier isEqualToString:identifier]) {
            
            [self p_removeExtremeValueWithIdentifier:identifier];
            [self.drawLogicArray removeObject:drawLogic];
            
            break;
        }
    }
    
    [self reDrawWithType:ReDrawTypeDefault];
    
    return self.drawLogicArray;
}

/**
 移除某个绘图算法
 
 @param logic 需要移除的绘图算法
 @return 移除以后的绘图算法集合
 */
- (NSArray <BaseDrawLogic *>* _Nullable)removeDrawLogicWithLogic:(BaseDrawLogic<ChartDrawProtocol>*)logic {
    
    if (logic && [self.drawLogicArray containsObject:logic]) {
        
        [self p_removeExtremeValueWithIdentifier:logic.drawLogicIdentifier];
        [self.drawLogicArray removeObject:logic];
    }
    
    [self reDrawWithType:ReDrawTypeDefault];
    
    return self.drawLogicArray;
}

/**
 根据缩放比例绘制
 
 @param scale 缩放比例
 */
- (void)reDrawWithScale:(CGFloat)scale {
    
    NSAssert(scale > 0, @"draw scale must > 0");
    if (scale > 0) {
        self.currentScale = scale;
        [self reDrawWithType:ReDrawTypeDefault];
    }
}

/**
 重新绘制
 缩放比例还是按照之前显示的比例
 @param drawType 绘制时采用的类型
 */
- (void)reDrawWithType:(ReDrawType)drawType {
    
    switch (drawType) {
        case ReDrawTypeDefault:
        {
            
        }
            break;
            
        case ReDrawTypeToTail:
        {
            // 回到尾部
            if ((self.dataCenter.klineModelArray.count - 1) <= self.maxItemCount) {
                
                if ((self.visibleRange.x >= self.dataCenter.klineModelArray.count - 1) || (self.visibleRange.y <= self.dataCenter.klineModelArray.count - 1)|| (self.visibleRange.x < -[self.config minShowKlineCount])) {
                    self.visibleRange = CGPointMake(0 , self.maxItemCount);
//                    NSLog(@"visibleRange y-4 = %f",self.visibleRange.y);
                }

            }else {
                
                self.visibleRange = CGPointMake(self.dataCenter.klineModelArray.count - self.maxItemCount, self.dataCenter.klineModelArray.count);
//                NSLog(@"visibleRange y-3 = %f",self.visibleRange.y);

            }
            
        }
            break;
            
        case ReDrawTypeToHead:
        {
            // 回到头部
            if (self.visibleRange.x >= 0) {
                self.visibleRange = CGPointMake(-1, self.maxItemCount - 1);
//                NSLog(@"visibleRange y-4 = %f",self.visibleRange.y);
            }
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    // 更新刷新后的visibleRange
    [self.dataLogic updateVisibleRange:self.visibleRange];
    
    [self setNeedsDisplay];
}


/* 数据中心的回调方法 */
#pragma mark - DataCenterProtocol ---
/**
 数据已经刷新
 
 @param dataCenter 数据中心
 @param modelArray 刷新后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didReload:(NSArray *)modelArray {
    
    [self reDrawWithType:ReDrawTypeDefault];
    
    self.isFirstLoad = NO;
}

/**
 数据已经被清空
 
 @param dataCenter 数据中心
 */
- (void)dataDidCleanAtDataCenter:(DataCenter *)dataCenter {
    
    [self reDrawWithType:ReDrawTypeDefault];
    
    self.isFirstLoad = YES;
}

/**
 在尾部添加了最新数据
 
 @param dataCenter 数据中心
 @param modelArray 添加后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didAddNewDataInTail:(NSArray *)modelArray {
    
    if (self.dataCenter.isFirstLoad || fabs(self.visibleRange.y - self.dataCenter.klineModelArray.count) <= 2.0f || (self.visibleRange.x >= self.dataCenter.klineModelArray.count - 1) || self.visibleRange.x < - [self.config minShowKlineCount]) {
        [self reDrawWithType:ReDrawTypeToTail];
    }else {
        [self reDrawWithType:ReDrawTypeDefault];
    }
    
    self.isFirstLoad = NO;
}

/**
 在头部添加了数据
 
 @param dataCenter 数据中心
 @param modelArray 添加后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didAddNewDataInHead:(NSArray *)modelArray {
    
    [self reDrawWithType:ReDrawTypeToHead];
    
    self.isFirstLoad = NO;
}

#pragma mark - 可见区域计算逻辑回调方法 ---

/**
 可见区域已经改变的回调方法
 
 @param visibleRange 改变后的可见区域
 */
- (void)visibleRangeDidChanged:(CGPoint)visibleRange scale:(CGFloat)scale {

    if (!CGPointEqualToPoint(self.visibleRange, visibleRange)) {
        self.visibleRange = visibleRange;
        self.currentScale = scale;
        self.perItemWidth = ([self.config defaultEntityLineWidth] + [self.config klineGap]) * self.currentScale;
        [self reDrawWithType:ReDrawTypeDefault];
    }
}

/**
 十字线是否在显示
 
 @param isShow 是否在显示
 */
- (void)reticleIsShow:(BOOL)isShow {
    
    self.isShowReticle = isShow;
    
}

/**
 KLineView 上触点移动的回调方法(十字线移动)
 
 @param view 触点起始的View
 @param point point 点击的点
 @param index index 当前触点所在item的下标
 */
- (void)klineView:(ASDKLineView *)view didMoveToPoint:(CGPoint)point selectedItemIndex:(NSInteger)index {
    
    if (index >= 0 && index < self.dataCenter.klineModelArray.count) {
        self.selectedModel = self.dataCenter.klineModelArray[index];
        [self reDrawWithType:ReDrawTypeDefault];
    }
}

#pragma mark - 私有方法 ---

/**
 初始化方法
 */


/**
 绘图方法
 
 @param drawLogic 绘图算法对象
 @param ctx 绘图上下文
 @param rect 绘图的区域
 */
- (void)drawWithLogic:(BaseDrawLogic *)drawLogic contentext:(CGContextRef)ctx rect:(CGRect)rect {
    
    NSDictionary *arguments = @{};
    CGRect newRect = rect;
    
    
    // 背景绘图算法传入附加参数和绘制的rect 进行特殊处理
    if ([drawLogic isMemberOfClass:[KLineBGDrawLogic class]]) {
        // 传入最大最小值
        arguments = @{KlineViewToKlineBGDrawLogicExtremeValueKey:[NSValue gl_valuewithGLExtremeValue:[self p_getExtremeValueFilterIdentifier:drawLogic.drawLogicIdentifier]]};
        
    }else {  // 其他绘图算法默认传入附加参数和处理后的rect
        if (self.selectedModel) {
            // 传入更新最大最小值的block
            arguments = @{updateExtremeValueBlockAtDictionaryKey:self.updateExtremeValueBlock,KlineViewToKlineBGDrawLogicExtremeValueKey:[NSValue gl_valuewithGLExtremeValue:[self p_getExtremeValueFilterIdentifier:drawLogic.drawLogicIdentifier]],KlineViewReticleSelectedModelKey:self.selectedModel};
        }else {
            // 传入更新最大最小值的block
            arguments = @{updateExtremeValueBlockAtDictionaryKey:self.updateExtremeValueBlock,KlineViewToKlineBGDrawLogicExtremeValueKey:[NSValue gl_valuewithGLExtremeValue:[self p_getExtremeValueFilterIdentifier:drawLogic.drawLogicIdentifier]]};
        }

        // 处理Rect
        newRect = CGRectMake(rect.origin.x + [self.config insertOfKlineView].left, rect.origin.y + [self.config insertOfKlineView].top, rect.size.width - ([self.config insertOfKlineView].left + [self.config insertOfKlineView].right), rect.size.height - ([self.config insertOfKlineView].top + [self.config insertOfKlineView].bottom));
    }
    
    // 绘制算法
    [drawLogic drawWithCGContext:ctx rect:newRect indexPathForVisibleRange:self.visibleRange scale:self.currentScale otherArguments:arguments];
}


/**
 添加默认的绘图算法
 默认为：背景绘图(KLineBGDrawLogic)算法
 */
- (void)p_addDefaultDrawLogic {
    
    // 背景绘图算法
    KLineBGDrawLogic *tempKlineBGDrawLogic = [[KLineBGDrawLogic alloc] initWithDrawLogicIdentifier:klineBGDrawLogicDefaultIdentifier];
    tempKlineBGDrawLogic.config = self.config;
    [self addDrawLogic:tempKlineBGDrawLogic];
    
}

/**
 bounds更新了后要更新显示区域
 */
- (void)p_updateVisibleRangeForNewBounds {
    
    if (!CGRectEqualToRect(CGRectZero, self.frame)) {
        self.perItemWidth = ([self.config defaultEntityLineWidth] + [self.config klineGap]) * self.currentScale;
        if(CGPointEqualToPoint(_visibleRange, CGPointZero)) {
            [self visibleRange];
        }else {
            self.visibleRange = CGPointMake(self.visibleRange.x, self.visibleRange.x + (self.frame.size.width - (self.config.insertOfKlineView.left + self.config.insertOfKlineView.right)) / self.perItemWidth);
        }
        
        [self.dataLogic updateVisibleRange:self.visibleRange];
        [self reDrawWithType:ReDrawTypeDefault];
    }
}

/**
 根据某个标识符移除保存的最大最小值
 
 @param identifier 标识符
 */
- (void)p_removeExtremeValueWithIdentifier:(NSString *)identifier {
    
    if (identifier && identifier.length >= 1) {
        [self.extremeValueDict removeObjectForKey:identifier];
    }
}

/**
 移除所有保存的最大最小值
 */
- (void)p_removeAllExtremeValues {
    
    [self.extremeValueDict removeAllObjects];
    
}

#pragma mark - 手势 处理 ----

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    // 记录开始的触点所在的x坐标
    self.beginPoint = [touch locationInView:self];
    self.lastTouchPointX = self.beginPoint.x;
    
    
    if (touch && ![self.touchArray containsObject:touch] && self.touchArray.count < 2) {
        [self.touchArray addObject:touch];
        self.touchBeginStamp = touch.timestamp;
    }
    
    if (self.touchArray.count >= 2) {
        self.lastPinchWidth = 0.0;
        self.isPinching = YES;
        self.touchBeginStamp = 0.0;
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self];
    if (touch && [self.touchArray containsObject:touch]) {
        [self.touchArray removeAllObjects];
        self.isPinching = NO;
        self.touchBeginStamp = 0.0;
    }
    
    
    if (self.isShowReticle) {
        // 隐藏十字线
        [self.dataLogic removeTouchAtKLineView:self touchPoint:endPoint perItemWidth:self.perItemWidth];
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [self.touchArray firstObject];
    CGPoint movePoint = [touch locationInView:self];
//    NSLog(@"move point = %@",NSStringFromCGPoint(movePoint));
    if (self.isPinching && self.touchArray.count >= 2) {
        // 缩放
        [self p_updateScaleAndVisibleRange];
        
//        NSLog(@"touch moved ： %d",self.isPinching);
    }else if(!self.isPinching && self.touchArray.count == 1) {
        
        if (!self.isShowReticle) {
            // 左右移动
            CGFloat offsetX = movePoint.x - self.lastTouchPointX;
            [self p_updateVisibleRangeWithOffseX:offsetX];
        }else {
            // 移动十字线
            [self.dataLogic moveTouchAtKLineView:self touchPoint:movePoint perItemWidth:self.perItemWidth];
        }
        
        // 移动超过2像素就算移动过
        if (fabs(self.beginPoint.x - movePoint.x) < 3.0 && fabs(self.beginPoint.y - movePoint.y) < 3.0) {
            if (touch.timestamp - self.touchBeginStamp >= 0.4) {
                if (!self.isShowReticle) {
                    // 开始显示十字线
                    NSLog(@"显示十字线");
                    [self.dataLogic beginTapKLineView:self touchPoint:movePoint perItemWidth:self.perItemWidth];
                }
            }
        }
        
        self.lastTouchPointX = movePoint.x;
    }
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    // 触摸事件被系统事件打断的处理
    [self.touchArray removeAllObjects];
    self.isPinching = NO;
}

#pragma mark - 手势计算 ---

/**
 更新缩放比例和当前显示区域
 */
- (void)p_updateScaleAndVisibleRange {
    
    
    if(!self.isPinching || self.isShowReticle || self.touchArray.count < 2) {
        return;
    }
    
    // 计算出中心点在x轴的比例
    CGPoint firstPoint = [[self.touchArray firstObject] locationInView:self];
    CGPoint secondPoint = [[self.touchArray objectAtIndex:1] locationInView:self];
    CGFloat currentPinchWidth = fabs(firstPoint.x - secondPoint.x);
    CGFloat touchCenterX = (firstPoint.x + secondPoint.x) / 2.0;
    CGFloat xPercent = touchCenterX / self.frame.size.width;
    
    if(self.lastPinchWidth == 0.0) {
        self.lastPinchWidth = currentPinchWidth;
        return;
    }
    // 计算缩放比例
    self.currentScale += (currentPinchWidth / self.lastPinchWidth - 1.0f);
    
    if (self.currentScale > [self.config maxPinchScale]) {
        self.currentScale = [self.config maxPinchScale];
    }else if(self.currentScale < [self.config minPinchScale]) {
        self.currentScale = [self.config minPinchScale];
    }
    // 计算每个元素的宽度
    self.perItemWidth = self.currentScale * ([self.config defaultEntityLineWidth] + [self.config klineGap]);
    // 计算当前显示的区域
    [self.dataLogic updateVisibleRangeWithZoomCenterPercent:xPercent perItemWidth:self.perItemWidth scale:self.currentScale];
    
    // 记录触点距离
    self.lastPinchWidth = currentPinchWidth;
}

/**
 更新滑动手势的偏移量和可见区域
 */
- (void)p_updateVisibleRangeWithOffseX:(CGFloat)offsetX {
    
    if (self.isPinching || self.isShowReticle) {
        NSLog(@"当缩放手势或者显示十字线时不能移动");
        return;
    }
    
    [self.dataLogic updateVisibleRangeWithOffsetX:offsetX perItemWidth:self.perItemWidth];
    
}

/**
 获得最大最小值
 
 @param identifier 过滤某个算法的最大最小值
 @return 共同的最大最小值
 */
- (GLExtremeValue)p_getExtremeValueFilterIdentifier:(NSString *)identifier {
    
    GLExtremeValue result = GLExtremeValueMake(CGFLOAT_MAX, 0.0f);
    
    for (NSString *tempKey in self.extremeValueDict) {
        if ([tempKey isEqualToString:identifier]) {
            continue;
        }
        
        NSValue *value = self.extremeValueDict[tempKey];
        GLExtremeValue tempValue = [value gl_extremeValue];
        result = GLExtremeValueMake(fmin(tempValue.minValue, result.minValue), fmax(tempValue.maxValue, result.maxValue));
    }
    
    return result;
}

#pragma mark - 懒加载 ----

- (NSMutableArray *)drawLogicArray {
    if(!_drawLogicArray) {
        _drawLogicArray = @[].mutableCopy;
    }
    return _drawLogicArray;
}

- (DataCenter *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [DataCenter shareCenter];
        [_dataCenter addDelegate:self];
    }
    return _dataCenter;
}

- (KLineDataLogic *)dataLogic {
    if (!_dataLogic) {
        _dataLogic = [[KLineDataLogic alloc] initWithVisibleRange:self.visibleRange perItemWidth:self.perItemWidth];
        // 设置最小显示个数
        _dataLogic.minKlineCount = [self.config minShowKlineCount];
        [_dataLogic addDelegate:self];
    }
    return _dataLogic;
}

- (NSObject<KLineViewProtocol> *)config {
    if (!_config) {
        _config = [[KLineViewConfig alloc] init];
    }
    return _config;
}

- (CGPoint)visibleRange {
    if (CGPointEqualToPoint(CGPointZero, _visibleRange) && self.dataCenter.klineModelArray.count >= 1) {
        
        CGFloat itemCount = (self.frame.size.width - (self.config.insertOfKlineView.left + self.config.insertOfKlineView.right)) / self.perItemWidth;
        
        _visibleRange = CGPointMake(self.dataCenter.klineModelArray.count - itemCount, self.dataCenter.klineModelArray.count);
    }
    return _visibleRange;
}

- (NSMutableArray<UITouch *> *)touchArray {
    if (!_touchArray) {
        _touchArray = @[].mutableCopy;
    }
    return _touchArray;
}

- (CGFloat)maxItemCount {
    
    _maxItemCount = (self.frame.size.width - ([self.config insertOfKlineView].left + [self.config insertOfKlineView].right)) / self.perItemWidth;
    
    return _maxItemCount;
}

/**
 更新最大最小值的block
 */
- (UpdateExtremeValueBlock)updateExtremeValueBlock {
    if (!_updateExtremeValueBlock) {
        __weak typeof(self)weakSelf = self;
        _updateExtremeValueBlock = ^(NSString *identifier ,double minValue,double maxValue) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            // 保存各算法的最大最小值
            [strongSelf.extremeValueDict setObject:[NSValue gl_valuewithGLExtremeValue:GLExtremeValueMake(minValue, maxValue)] forKey:identifier];
            
            GLExtremeValue tempOtherExtreme = [strongSelf p_getExtremeValueFilterIdentifier:identifier];
            GLExtremeValue tempDrawExtreme = GLExtremeValueMake(fmin(minValue, tempOtherExtreme.minValue), fmax(maxValue, tempOtherExtreme.maxValue));
//            NSLog(@"id:%@,min:%f,max:%f",identifier,minValue,maxValue);
            if (!GLExtremeValueEqualToExtremeValue(strongSelf.currentExtremeValue, tempDrawExtreme)) {
                strongSelf.currentExtremeValue = tempDrawExtreme;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [strongSelf setNeedsDisplay];
                });
            }
        };
    }
    return _updateExtremeValueBlock;
}

- (NSMutableDictionary *)extremeValueDict {
    if (!_extremeValueDict) {
        _extremeValueDict = @{}.mutableCopy;
    }
    return _extremeValueDict;
}
@end
