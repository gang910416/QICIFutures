

#import <Foundation/Foundation.h>
@class OrderBookModel,KLineModel,ASDMarketListModel;
NS_ASSUME_NONNULL_BEGIN

@interface QCMarketLogic : NSObject

/**
 根据周期获得所传参数的时间间隔

 @param timeType 时间周期(1日、1周)
 @return 时间间隔，1分=60，1日=86400
 */
+ (NSString *)getTimeInervalWithTimeType:(NSString *)timeType;

/**
 搜索股票
 
 @param symbol 股票代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)searchStockDataWithSymbol:(NSString *)symbol success:(void (^)(NSArray <ASDMarketListModel *> * searchList))suc faild:(void (^)(NSError *error))faild;

#pragma mark - 期货相关 --

/* 市场名称 */
+ (NSArray <NSString *> *)getMarketNames;

/**
 期货symbols
 */
+ (NSDictionary *)getFutureMarketSymbols;

/**
 根据市场获得期货的symbols
 
 @param identifer 市场的标识
 */
+ (NSArray <NSString *>*)getSymbolsWithMarketIdentifer:(NSString *)identifer;

/**
 获得期货市场的列表
 
 @param codes 期货代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)futureMarketListDataWithCodes:(NSString *)codes market:(NSString *)marketName success:(void(^) (NSArray <ASDMarketListModel *>* list))suc faild:(void (^)(NSError *))faild;

/**
 获得股票K线数据

 @param market  股票市场
 @param symbol 股票代码
 @param timeInterval K线周期
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)futureGetKlineDateWithMarket:(NSString *)market symbol:(NSString *)symbol timeType:(NSString *)timeInterval success:(void (^)(NSArray <KLineModel *> * klineArray))suc faild:(void (^)(NSError *error))faild;

@end

NS_ASSUME_NONNULL_END
