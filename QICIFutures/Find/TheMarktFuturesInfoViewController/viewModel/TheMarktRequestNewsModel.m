//
//  TheMarktRequestNewsModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "TheMarktRequestNewsModel.h"
#import "TheMarktNewsModel.h"

@implementation TheMarktRequestNewsModel

-(void)requestFuturesNewsInfoSuccess:(void (^)(NSArray * _Nonnull))success failture:(void (^)(NSString * _Nonnull))failture timeout:(void (^)(void))timeout{
    
    NSString *urlStr = @"http://efn.htmt168.com/fApi/contentList?categoryId=125&pageIndex=1&count=5&_t=1557817909";
    
    [[HttpRequest sharedInstance] oneGet:@"" path:urlStr parameters:nil success:^(id responsData) {
        
        if (responsData) {
            NSError *err;
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:&err];
            if (!err) {
                
                if (data[@"list"]) {
                    NSArray *list = data[@"list"];
                    if (list.count > 0) {
                        NSMutableArray *result = [NSMutableArray array];
                        
                        for (NSDictionary *dic in list) {
                            TheMarktNewsModel *model = [TheMarktNewsModel mj_objectWithKeyValues:dic];
                            [result addObject:model];
                        }
                        success(result);
                    }
                }
            }
        }
        
    } faile:^(NSError *error) {
        timeout();
    }];
    
    
}

@end
