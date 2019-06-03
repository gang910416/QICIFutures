//
//  TheMarktRequestViewModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktRequestViewModel : NSObject

/**
 请求国内期货所有数据

 @param success <#success description#>
 @param failture <#failture description#>
 */
-(void)requestAllFuturesNameInfoSuccess:(void(^)(void))success failture:(void(^)(NSString *error))failture;

/**
 请求国内菜油期货数据

 @param success <#success description#>
 @param failture <#failture description#>
 */
-(void)requestAllFuturesVOilNameInfoSuccess:(void(^)(void))success failture:(void(^)(NSString *error))failture;

/**
 请求快讯

 @param success <#success description#>
 @param failture <#failture description#>
 */
-(void)requestFastNewsSuccess:(void(^)(NSString *resultString))success failture:(void(^)(NSString *error))failture;

@property (nonatomic,strong) NSMutableArray *fastNewsArray;

@end

NS_ASSUME_NONNULL_END
