//
//  SaveAndUseFuturesDataModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveAndUseFuturesDataModel : NSObject

/**
 保存关注期货

 @param code 期货代码
 @param name 期货名称   保存格式@{}
 */
+(void)saveLikeFutures:(NSString * _Nonnull)code name:(NSString * _Nonnull)name;

/**
 移除关注期货

 @param code 期货代码
 */
+(void)removeLikeFutures:(NSString * _Nonnull)code;

/**
 根据期货代码判断是否是关注期货

 @param code 期货代码
 @return 是否关注
 */
+(BOOL)isLikeFutures:(NSString *)code;

/**
 获取所有关注期货

 @return 所有关注期货数组
 */
+(NSArray *)getMyLikelist;

/**
 获取所有国内期货

 @return 国内期货
 */
+(NSArray *)getAllDomesticFuturesInfo;

/**
 保存所有国内期货

 @param array 所有国内期货数组
 */
+(void)saveAllDomesticFuturesInfoWithArray:(NSArray *)array;

/**
 获取所有国内菜油期货

 @return 国内菜油期货
 */
+(NSArray *)getAllDomesticVegetableOilFuturesInfo;

/**
 保存所有菜油期货

 @param array 菜油期货数组
 */
+(void)saveAllDomesticVegetableOilInfoWithArray:(NSArray *)array;


/**
 获取所有国际商品期货

 @return 以交易所为key的商品期货数组字典
 */
+(NSDictionary *)getAllForeignGoodsFuturesInfo;

/**
 保存国外商品期货,写死在本地
 */
+(void)saveAllForeignGoodsFuturesInfo;

/**
 获取所有国外股指期货

 @return 股指期货
 */
+(NSArray *)getAllForeignStockIndexFuturesInfo;

/**
 保存股指期货,写死在本地
 */
+(void)saveAllForeignStockIndexFuturesInfo;

/**
 获取所有国外外汇期货

 @return 外汇期货
 */
+(NSArray *)getAllForeigncCurrencyFuturesInfo;

/**
 保存外汇期货,写死在本地
 */
+(void)saveAllForeigncCurrencyFuturesInfo;

/**
 判断是否登录,登录之后才能使用关注功能

 @return 是否登录
 */
+(BOOL)isLogin;

/**
 获取现在登录的账号信息

 @return 账号信息
 */
+(NSDictionary *)getNowLoginInfo;

/**
 判断是否是国内期货,或者国外期货

 @param code 期货代码
 @return 是否是国内期货,否==国外期货
 */
+(BOOL)getCodeIsDomestic:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
