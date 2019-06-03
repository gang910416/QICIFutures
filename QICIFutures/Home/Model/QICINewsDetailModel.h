//
//  EEEHomeNewsModel.h
// ASDFutureProject
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QICINewsDetailModel : NSObject

@property (strong, nonatomic) NSString *digest;
@property (strong, nonatomic) NSString *newsType;
@property (strong, nonatomic) NSString *newsId;
@property (strong, nonatomic) NSString *realPublishTime;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *shareUrl;
@property (strong, nonatomic) NSString *body;

/**
 生成一个默认的假的新闻模型
 */
+ (instancetype)createModelWithReq:(NSDictionary *)reqDict;

@end

NS_ASSUME_NONNULL_END
