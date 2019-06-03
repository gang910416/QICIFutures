//
//  TheMarktRequestViewModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktRequestViewModel.h"
#import "TheMarktFastNewsModel.h"

@implementation TheMarktRequestViewModel

-(NSMutableArray *)fastNewsArray{
    
    if (!_fastNewsArray) {
        _fastNewsArray = [NSMutableArray array];
    }
    return _fastNewsArray;
}

-(void)requestAllFuturesNameInfoSuccess:(void (^)(void))success failture:(nonnull void (^)(NSString * _Nonnull))failture{
    
    NSDictionary *param = @{@"token":tokenKey};
    
    [[HttpRequest sharedInstance] oneGet:@"" path:@"http://data.api51.cn/apis/symbol/cnfutures/" parameters:param success:^(id responsData) {
        
        if (responsData) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:&err];
            if (!err) {
                if (dic[@"result"]) {
                    NSDictionary *result = dic[@"result"];
                    if (result[@"data"]) {
                        NSDictionary *data = result[@"data"];
                        if (data[@"inner_detail"]) {
                            NSArray *dataArray = data[@"inner_detail"];
                            [SaveAndUseFuturesDataModel saveAllDomesticFuturesInfoWithArray:dataArray];
                        }else{
                            failture(@"获取国内期货信息失败");
                        }
                    }else{
                       failture(@"获取国内期货信息失败");
                    }
                }else{
                    failture(@"获取国内期货信息失败");
                }
            }else{
                failture(@"获取国内期货信息失败");
            }
        }
        
    } faile:^(NSError *error) {
        failture(@"超时");
    }];
}

-(void)requestAllFuturesVOilNameInfoSuccess:(void (^)(void))success failture:(nonnull void (^)(NSString * _Nonnull))failture{
    
    NSDictionary *param = @{@"token":tokenKey,@"type":@"OI0"};
    
    [[HttpRequest sharedInstance] oneGet:@"" path:@"http://data.api51.cn/apis/symbol/cnfutures/" parameters:param success:^(id responsData) {
        
        if (responsData) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:&err];
            if (!err) {
                if (dic[@"result"]) {
                    NSDictionary *result = dic[@"result"];
                    if (result[@"data"]) {
                        NSDictionary *data = result[@"data"];
                        if (data[@"inner_detail"]) {
                            NSArray *dataArray = data[@"inner_detail"];
                            [SaveAndUseFuturesDataModel saveAllDomesticVegetableOilInfoWithArray:dataArray];
                        }else{
                            failture(@"获取国内菜油期货信息失败");
                        }
                    }else{
                        failture(@"获取国内菜油期货信息失败");
                    }
                }else{
                    failture(@"获取国内菜油期货信息失败");
                }
            }else{
                failture(@"获取国内菜油期货信息失败");
            }
        }
        
    } faile:^(NSError *error) {
        failture(@"超时");
    }];
}

-(void)requestFastNewsSuccess:(void (^)(NSString * _Nonnull))success failture:(void (^)(NSString * _Nonnull))failture{
    
    NSString *urlStr = [NSString stringWithFormat:@"https://mapi.followme.com/app/v1/social2/fire/news?pageIndex=%d",1];
    
    [[HttpRequest sharedInstance] oneGet:@"" path:urlStr parameters:nil success:^(id responsData) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:&err];
        
        if (!err) {
            if (dic[@"data"]) {
                NSDictionary *data = dic[@"data"];
                
                if (data[@"Items"]) {
                    NSArray *items = data[@"Items"];
                    if (items.count > 0) {
                        NSDictionary *dic = items[0];
                        if (dic[@"Items"]) {
                            NSArray *arr = dic[@"Items"];
                            
                            [self.fastNewsArray removeAllObjects];
                            for (NSDictionary *dic in arr) {
                                TheMarktFastNewsModel *model = [TheMarktFastNewsModel mj_objectWithKeyValues:dic];
                                [self.fastNewsArray addObject:model];
                            }
//                            success(self.fastNewsArray);
                            NSMutableString *result = [NSMutableString string];
//                            for (TheMarktFastNewsModel *model in self.fastNewsArray) {
//                                [result appendString:[NSString stringWithFormat:@"%@--%@>>>",model.UpdateTime,model.Title]];
//                            }
                            for (int i = 0 ; i < 3; i ++) {
                                if (self.fastNewsArray.count > i) {
                                    TheMarktFastNewsModel *model = self.fastNewsArray[i];
                                    [result appendString:[NSString stringWithFormat:@"%@--%@>>>",model.UpdateTime,model.Title]];
                                }else{
                                    break;
                                }
                            }
                            success(result);
                        }
                        
                    }
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [SVProgressHUD dismissWithDelay:1];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [SVProgressHUD dismissWithDelay:1];
        }
        
    } faile:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD dismissWithDelay:1];
    }];
}


@end
