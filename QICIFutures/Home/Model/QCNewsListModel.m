//
//  QCNewsListModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "QCNewsListModel.h"

@implementation QCNewsListModel
/**
 生成一个默认的假的新闻模型
 */
+ (instancetype)createHomeNewsModel {
    
    QCNewsListModel *homeNewModel = [[QCNewsListModel alloc] init];
    
    homeNewModel.title = @"上海人工智能产业加速推进 2019人工智能领域项目指南发布";
    homeNewModel.time = @"2019-05-13 21:09";
    homeNewModel.imgsrc1 = @"http://40.125.165.114:9803/static/bolanjr/bolanjrwxtwo/zxjt/566.jpg?domain=http://dfs.csc108.com";
    homeNewModel.source = @"博览财经";
    homeNewModel.newsId = @"15577521038312620";
    homeNewModel.topic = @"L295";
    return homeNewModel;
}
@end
