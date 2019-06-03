//
//  ASDNewsLogic.h
// ASDFutureProject
//
//  Created by Mac on 2019/5/15.
//  Copyright © 2019 ASD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QCNewsDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface QICINewsLogic : NSObject

/**
 获得新闻详情的方法

 @param newsId 新闻id
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getNewsDetailWithNewsId:(NSString *)newsId blockSuccess:(void (^)(QCNewsDetailModel * _Nullable detailModel))suc faild:(void (^)(NSError * _Nullable error))faild;

@end

NS_ASSUME_NONNULL_END
