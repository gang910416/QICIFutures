//
//  QCHomeDataMannger.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "QCHomeDataMannger.h"
#import "QICIMarkeModel.h"
#import "QCNewsListModel.h"
@implementation QCHomeDataMannger

+ (void)getMarketIndexWithBlockSuccess:(void (^)(NSArray <QICIMarkeModel *> * list))suc faild:(void (^)(NSError *error))faild{
    
    NSString *path = @"real";
    
    NSArray *allCode = [[self getHomeIndexCodes] allKeys];
    
    NSString *prod_code = [allCode componentsJoinedByString:@","];
    
    NSString *fields = [HOMEBACKDATA componentsJoinedByString:@","];
    
    NSDictionary *params = @{@"token":APPKEY51,@"prod_code":prod_code,@"fields":fields ? : @""};
    
    [[QICIHTTPRequest sharedInstance] oneGet:DATAURL51 path:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *list = @[];
        
        if (responseObject) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            if (data && data.count > 0 && [data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *snapShot = [data objectForKey:@"snapshot"];
                
                list = [self p_processIndexModelWithSnapShot:snapShot];
            }
        }
        
        !suc ? : suc(list);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          !faild ? : faild(error);
    }];
    
}
/**
 请求首页期货排行列表
 
 @param market 市场
 @param asce 是否正序排列
 @param count 列表最大个数
 */
+ (void)getHomeMarketListWithMarket:(NSString *)market isAsce:(BOOL)asce reqCount:(NSUInteger)count blockSuccess:(void (^)(NSArray <QICIMarkeModel *> * list))blockSuccess blockfaild:(void (^)(NSError *error))blockfaild{
   
    //http://data.api51.cn/apis/integration/
    
    NSString *filed = [HOMEBACKDATA componentsJoinedByString:@","];
     NSMutableDictionary *params = [NSMutableDictionary dictionary];//参数字典
    [params setObject:isStrEmpty(market) ? @"" : market forKey:@"market_type"];
    [params setObject:[@(count)stringValue] forKey:@"limit"];
    [params setObject:!asce ? @"asc" : @"desc" forKey:@"order_by"];
    [params setObject:filed forKey:@"fields"];
    [params setObject:APPKEY51 forKey:@"token"];
    
    [[QICIHTTPRequest sharedInstance] oneGet:DATAURL51 path:@"rank" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dataArray = [NSArray array];
        if (responseObject) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            if (data  && [data isKindOfClass:[NSDictionary class]] && data.count > 0 ) {
                NSArray *candle = [data objectForKey:@"candle"];
                
                dataArray = [self processHomeMarketListWithArray:candle market:market];
            }
        }
        !blockSuccess ? :blockSuccess(dataArray);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
     
    
}

+ (void)getHomeNewsWithSinceId:(NSString *)sinceId count:(NSInteger)count blockSuccess:(void (^)(NSArray <QCNewsListModel *> * list))sucess faild:(void (^)(NSError *error))faild
{
    NSString *countString = @"5";
    
    if (count >= 5) {
        countString = [@(count) stringValue];
    }
    
    NSDictionary *param = @{@"req_count":countString,@"req_sinceId":isStrEmpty(sinceId) ? @"0" : sinceId,@"req_funType":@"L295"};
    
    
    [[QICIHTTPRequest sharedInstance]oneGet:HOMENewsList path:@"" parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *list = @[];
        
        if (responseObject) {
            NSDictionary *newsDict = [responseObject objectForKey:@"news"];
            if (newsDict && [newsDict isKindOfClass:[NSArray class]] && newsDict.count > 0 ) {
                //d字典转模型
                list = [NSArray yy_modelArrayWithClass:[QCNewsListModel class] json:newsDict];
            }
        }
         !sucess ? : sucess(list);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           !faild ? : faild(error);
    }];
    
}

+ (NSArray <QICIMarkeModel *>*)processHomeMarketListWithArray:(NSArray *)candle market:(NSString *)marketString {
    
    NSMutableArray *list = @[].mutableCopy;
    
    if(candle && [candle isKindOfClass:[NSArray class]] && candle.count > 0) {
        
        for (NSArray *tempArray in candle) {
            
            QICIMarkeModel *tempModel = [QICIMarkeModel createModelWithArray:tempArray];
            tempModel.market_type = marketString;
            
            if (tempModel) {
                [list addObject:tempModel];
            }
        }
    }
    return list;
}


+ (NSArray <QICIMarkeModel *>*)processMarketModelWithDicitionay:(NSDictionary *)dic{
    
    NSMutableArray *homeDataArray = @[].mutableCopy;
    
    if(dic && [dic isKindOfClass:[NSDictionary class]] && dic.count > 0) {
        
        NSArray *codes = [dic allKeys];
        
        for (int i = 0; i < codes.count; i ++) {
            NSString *tempKey = [codes objectAtIndex:i];
            NSArray *dataArray = [dic objectForKey:tempKey];
            QICIMarkeModel *tempModel = [QICIMarkeModel createModelWithArray:dataArray];
            
            if (tempModel) {
                [homeDataArray addObject:tempModel];
            }
        }
    }
    return homeDataArray;
}

/**
 获得首页指数code集合
 @{code:name}
 @{1A0002:@"A股指数"}
 */
+ (NSDictionary *)getHomeIndexCodes {
    
    NSDictionary *codes = @{
                            //                            @"000001.SS":@"上证指数",
                            //                            @"399001.SZ":@"深证成指",
                            //                            @"399006.SZ":@"创业板指",
                            //                            @"HSI.HKEX":@"恒生指数",
                            //                            @"US30.OTC":@"道琼斯",
                            //                            @"NAS.OTC":@"纳斯达克",
                            //                            @"US500.OTC":@"标普500",
                            //                            @"000002.SS":@"A股指数",
                            //                            @"000003.SS":@"B股指数",
                            //                            @"000300.SS":@"沪深300",
                            //                            @"000016.SS":@"上证50"
                            //                            @"JP225.OTC":@"日经225指数"
                            @"CNA50F.OTC":@"富时中国A50指数期货",
                            @"HK40F.OTC":@"恒生指数期货",
                            @"US30F.OTC":@"道琼斯指数期货",
                            @"US500F.OTC":@"标普500指数期货",
                            @"USTEC100F.OTC":@"纳斯达克100指数期货",
                            @"DE30F.OTC":@"德国30指数期货",
                            @"AU200F.OTC":@"澳洲200指数期货",
                            @"JP225F.OTC":@"日经225指数期货",
                            @"STOXX50F.OTC":@"欧洲50指数期货",
                            @"ES35F.OTC":@"西班牙35指数期货",
                            @"UK100F.OTC":@"英国100指数期货",
                            @"FR40F.OTC":@"法国40指数期货"
                            };
    return codes;
}

/**
 根据指数代码获得市场代码
 
 @param code 指数代码
 */
+ (NSString *)getMarketCodeWithIndexCode:(NSString *)code {
    
    NSDictionary *marketCodes = @{
                                  @"000001.SS":@"sh",
                                  @"399001.SZ":@"sz",
                                  @"399006.SZ":@"sz",
                                  @"HSI.HKEX":@"hk",
                                  @"US30.OTC":@"usa",
                                  @"NAS.OTC":@"usa",
                                  @"US500.OTC":@"usa",
                                  @"000002.SS":@"sh",
                                  @"000003.SS":@"sh",
                                  @"000300.SS":@"sh",
                                  @"000016.SS":@"sh"
                                  //                            @"JP225.OTC":@"日经225指数"
                                  };
    NSString *marketCode = [marketCodes objectForKey:code];
    
    return !isStrEmpty(marketCode) ? marketCode : @"";
}
+ (NSArray <QICIMarkeModel *>*)p_processIndexModelWithSnapShot:(NSDictionary *)snap {
         
         NSMutableArray *list = @[].mutableCopy;
         
         if(snap && [snap isKindOfClass:[NSDictionary class]] && snap.count > 0) {
             
             NSArray *codes = [[self getHomeIndexCodes] allKeys];
             
             // 排序
             codes = [codes sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                 
                 NSString *code1 = (NSString *)obj1;
                 NSString *code2 = (NSString *)obj2;
                 
                 return [code1 compare:code2];
             }];
             
             
             for (int i = 0; i < codes.count; i ++) {
                 NSString *tempKey = [codes objectAtIndex:i];
                 NSArray *dataArray = [snap objectForKey:tempKey];
                 QICIMarkeModel *tempModel = [QICIMarkeModel createModelWithArray:dataArray];
                 
                 if (tempModel) {
                     [list addObject:tempModel];
                 }
             }
         }
         return list;
     }

@end
