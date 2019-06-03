//
//  QCHomeDataMannger.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <Foundation/Foundation.h>

@class QICIMarkeModel,QCNewsListModel;

NS_ASSUME_NONNULL_BEGIN

@interface QCHomeDataMannger : NSObject

/**
 获得指数
 
 @param suc 成功block
 @param faild 失败block
 */
+ (void)getMarketIndexWithBlockSuccess:(void (^)(NSArray <QICIMarkeModel *> * list))suc faild:(void (^)(NSError *error))faild;
/**
 请求首页期货排行列表
 
 @param market 市场
 @param asce 是否正序排列
 @param count 列表最大个数
 */
+ (void)getHomeMarketListWithMarket:(NSString *)market isAsce:(BOOL)asce reqCount:(NSUInteger)count blockSuccess:(void (^)(NSArray <QICIMarkeModel *> * list))blockSuccess blockfaild:(void (^)(NSError *error))blockfaild;

/**
 获得财经资讯
 
 @param sucess 成功回调
 @param faild 失败回调
 */
+ (void)getHomeNewsWithSinceId:(NSString *)sinceId count:(NSInteger)count blockSuccess:(void (^)(NSArray <QCNewsListModel *> * list))sucess faild:(void (^)(NSError *error))faild;
/**
 处理多个股票查找结果
 
 @param dic 结果数据
 */
+ (NSArray <QICIMarkeModel *>*)processMarketModelWithDicitionay:(NSDictionary *)dic;

/**
 获得首页指数code集合(适用于api51)
 @{code:name}
 @{1A0002:@"A股指数"}
 */
+ (NSDictionary *)getHomeIndexCodes;

/**
 根据指数代码获得市场代码
 
 @param code 指数代码
 */
+ (NSString *)getMarketCodeWithIndexCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
