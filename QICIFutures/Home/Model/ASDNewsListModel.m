//
//  ASDNewsListModel.m
// ASDFutureProject
//
//  Created by Mac on 2019/5/15.
//  Copyright © 2019 ASD. All rights reserved.
//

#import "ASDNewsListModel.h"

@implementation ASDNewsListModel
/**
 生成一个默认的假的新闻模型
 */
+ (instancetype)createDefaultModel {
    
    ASDNewsListModel *newModel = [[ASDNewsListModel alloc] init];
    
    newModel.title = @"上海人工智能产业加速推进 2019人工智能领域项目指南发布";
    newModel.time = @"2019-05-13 21:09";
    newModel.imgsrc1 = @"http://40.125.165.114:9803/static/bolanjr/bolanjrwxtwo/zxjt/566.jpg?domain=http://dfs.csc108.com";
    newModel.source = @"博览财经";
    newModel.newsId = @"15577521038312620";
    newModel.topic = @"L295";
    return newModel;
}

@end
