//
//  QCNewsLogic.h
//  QICIFutures
//
//  Created by mac on 2019/6/3.
//

#import <Foundation/Foundation.h>
@class ASDNewsDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface QCNewsLogic : NSObject
/**
 获得新闻详情的方法
 
 @param newsId 新闻id
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getNewsDetailWithNewsId:(NSString *)newsId blockSuccess:(void (^)(ASDNewsDetailModel * _Nullable detailModel))suc faild:(void (^)(NSError * _Nullable error))faild;

@end

NS_ASSUME_NONNULL_END
