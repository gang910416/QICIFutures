//
//  QCNewsLogic.m
//  QICIFutures
//
//  Created by mac on 2019/6/3.
//

#import "QCNewsLogic.h"
#import "QCNewsDetailModel.h"
@implementation QCNewsLogic
/**
 获得新闻详情的方法
 
 @param newsId 新闻id
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getNewsDetailWithNewsId:(NSString *)newsId blockSuccess:(void (^)(ASDNewsDetailModel * detailModel))suc faild:(void (^)(NSError *error))faild {
    
    NSDictionary *params = @{@"id":isStrEmpty(newsId) ? @"15577989028315098" : newsId,@"type":@"L295"};
    
    [[QICIHTTPRequest sharedInstance] oneGet:APINewsDetail path:@"" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ASDNewsDetailModel *model = nil;
        
        if (responseObject) {
            
            model = [QCNewsDetailModel createModelWithReq:responseObject];
            
        }
        !suc ? : suc(model);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        !faild ? : faild(error);
        
    }];
}

@end
