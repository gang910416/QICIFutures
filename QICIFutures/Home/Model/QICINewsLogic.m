//
//  ASDNewsLogic.m
// ASDFutureProject
//
//  Created by Mac on 2019/5/15.
//  Copyright © 2019 ASD. All rights reserved.
//

#import "QICINewsLogic.h"
#import "QICINewsDetailModel.h"
@implementation QICINewsLogic
/**
 获得新闻详情的方法
 
 @param newsId 新闻id
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getNewsDetailWithNewsId:(NSString *)newsId blockSuccess:(void (^)(QICINewsDetailModel * detailModel))suc faild:(void (^)(NSError *error))faild {
    
    NSDictionary *params = @{@"id":isStrEmpty(newsId) ? @"15577989028315098" : newsId,@"type":@"L295"};
    
    [[QICIHTTPRequest sharedInstance]oneGet:APINewsDetail path:@"" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QICINewsDetailModel *model = nil;
        
        if (responseObject) {
            
            model = [QICINewsDetailModel createModelWithReq:responseObject];
            
        }
        !suc ? : suc(model);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !faild ? : faild(error);
    }];
  
    
}


@end
