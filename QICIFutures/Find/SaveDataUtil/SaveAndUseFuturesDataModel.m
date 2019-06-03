//
//  SaveAndUseFuturesDataModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "SaveAndUseFuturesDataModel.h"

@implementation SaveAndUseFuturesDataModel

+(void)saveLikeFutures:(NSString *)code name:(NSString *)name{
    
    NSDictionary *dic = @{code.uppercaseString:name};
    
    if ([self.class isLogin]) {
        
        if ([TheMarktUserDefault objectForKey:AllMyLikeFutures]) {
            NSDictionary *dict = [TheMarktUserDefault objectForKey:AllMyLikeFutures];
            
            NSString *userName = [self.class getNowLoginInfo];
            
            if ([dict objectForKey:userName]) {
                NSArray *userArr = [dict objectForKey:userName];
                BOOL isAdd = YES;
                for (NSDictionary *dic in userArr) {
                    if ([dic.allKeys.firstObject isEqualToString:code.uppercaseString]) {
                        isAdd = NO;
                        break;
                    }
                }
                if (isAdd) {
                    NSMutableArray *temp = [userArr mutableCopy];
                    [temp addObject:dic];
                    NSArray *tempArr = [NSArray arrayWithArray:temp];
                    
                    NSMutableDictionary *dicbb = [dict mutableCopy];
                    [dicbb setObject:tempArr forKey:userName];
                    
                    NSDictionary *tempDict = [NSDictionary dictionaryWithDictionary:dicbb];
                    
                    [TheMarktUserDefault setObject:tempDict forKey:AllMyLikeFutures];
                    
                    [TheMarktUserDefault synchronize];
                }
            }else{
                
                NSMutableDictionary *di = [dict mutableCopy];
                [di setObject:@[dic] forKey:userName];
                NSDictionary *dicaa = [NSDictionary dictionaryWithDictionary:di];
                
                [TheMarktUserDefault setObject:dicaa forKey:AllMyLikeFutures];
                [TheMarktUserDefault synchronize];
            }
        }else{
            NSString *userName = [self.class getNowLoginInfo];
            
            NSDictionary *dicss = @{userName:@[@{code:name}]};
            
            [TheMarktUserDefault setObject:dicss forKey:AllMyLikeFutures];
            [TheMarktUserDefault synchronize];
            
        }
    }
}

+(void)removeLikeFutures:(NSString *)code{
    
    if ([self.class isLogin]) {
        
        if ([TheMarktUserDefault objectForKey:AllMyLikeFutures]) {
            NSDictionary *dict = [TheMarktUserDefault objectForKey:AllMyLikeFutures];
            
            NSString *userName = [self.class getNowLoginInfo];
            
            if ([dict objectForKey:userName]) {
                NSArray *userArr = [dict objectForKey:userName];
                
                NSMutableArray *temp = [userArr mutableCopy];
                
                for (NSDictionary *dic in temp) {
                    if ([dic.allKeys.firstObject isEqualToString:code.uppercaseString]) {
                        [temp removeObject:dic];
                        break;
                    }
                }
                NSArray *tempArr = [NSArray arrayWithArray:temp];
                NSMutableDictionary *dictt = [dict mutableCopy];
                [dictt setObject:tempArr forKey:userName];
                
                NSDictionary *dicaa = [NSDictionary dictionaryWithDictionary:dictt];
                
                [TheMarktUserDefault setObject:dicaa forKey:AllMyLikeFutures];
                [TheMarktUserDefault synchronize];
            }
        }
    }
}

+(BOOL)isLikeFutures:(NSString *)code{
    
    if ([self.class isLogin]) {
        
        if ([TheMarktUserDefault objectForKey:AllMyLikeFutures]) {
            NSDictionary *dict = [TheMarktUserDefault objectForKey:AllMyLikeFutures];
            
            NSString *userName = [self.class getNowLoginInfo];
            
            if ([dict objectForKey:userName]) {
                NSArray *userArr = [dict objectForKey:userName];
                
                BOOL isLike = NO;
                for (NSDictionary *dic in userArr) {
                    if ([dic.allKeys.firstObject isEqualToString:code.uppercaseString]) {
                        isLike = YES;
                        break;
                    }
                }
                return isLike;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
        
    }else{
        
        return NO;
    }
}

+(NSArray *)getMyLikelist{
    
    if ([self.class isLogin]) {
        
        if ([TheMarktUserDefault objectForKey:AllMyLikeFutures]) {
            NSDictionary *dict = [TheMarktUserDefault objectForKey:AllMyLikeFutures];
            
            NSString *userName = [self.class getNowLoginInfo];
            
            if ([dict objectForKey:userName]) {
                
                NSArray *userArr = [dict objectForKey:userName];
                return userArr;
                
            }else{
                return @[];
            }
        }else{
            return @[];
        }
        
    }else{
        return @[];
    }
}

+(NSArray *)getAllDomesticFuturesInfo{
    
    if ([TheMarktUserDefault objectForKey:AllDomesticFutures]) {
        return [TheMarktUserDefault objectForKey:AllDomesticFutures];
    }
    
    return @[];
}

+(void)saveAllDomesticFuturesInfoWithArray:(NSArray *)array{
    
    [TheMarktUserDefault setObject:array forKey:AllDomesticFutures];
    [TheMarktUserDefault synchronize];
}

+(NSArray *)getAllDomesticVegetableOilFuturesInfo{
    
    if ([TheMarktUserDefault objectForKey:AllDomesticVegetableOilFutures]) {
        return [TheMarktUserDefault objectForKey:AllDomesticVegetableOilFutures];
    }
    
    return @[];
}

+(void)saveAllDomesticVegetableOilInfoWithArray:(NSArray *)array{
    
    [TheMarktUserDefault setObject:array forKey:AllDomesticVegetableOilFutures];
    [TheMarktUserDefault synchronize];
}

+(NSDictionary *)getAllForeignGoodsFuturesInfo{
    
    if ([TheMarktUserDefault objectForKey:AllForeignGoodsFutures]) {
        return [TheMarktUserDefault objectForKey:AllForeignGoodsFutures];
    }
    
    return @{};
}

+(void)saveAllForeignGoodsFuturesInfo{
    
    NSDictionary *dic = @{@"纽约商业交易所":@[
                                  @{@"NG":@"天然气"},
                                  @{@"CL":@"原油"},
                                  @{@"GC":@"黄金"},
                                  @{@"SI":@"白银"},
                                  @{@"HG":@"铜"}
                                  ],
                          @"伦敦金属交易所(LME)":@[
                                  @{@"CAD":@"铜"},
                                  @{@"AHD":@"铝"},
                                  @{@"ZSD":@"锌"},
                                  @{@"SND":@"锡"},
                                  @{@"PBD":@"铅"},
                                  @{@"NID":@"镍"}
                                  ],
                          @"芝加哥商品交易所(CBOT)":@[
                                  @{@"W":@"小麦"},
                                  @{@"C":@"玉米"},
                                  @{@"S":@"黄豆"},
                                  @{@"BO":@"黄豆油"},
                                  @{@"SM":@"黄豆粉"},
                                  @{@"LHC":@"瘦猪肉"}
                                  ],
                          @"美国洲际交易所(ICE)":@[
                                  @{@"OIL":@"布伦特原油"}
                                  ],
                          @"银行间柜台撮合交易":@[
                                  @{@"XAU":@"伦敦金"},
                                  @{@"XAG":@"伦敦银"},
                                  @{@"XPT":@"伦敦铂金"},
                                  @{@"XPD":@"伦敦钯金"}
                                  ],
                          };
    
    [TheMarktUserDefault setObject:dic forKey:AllForeignGoodsFutures];
    [TheMarktUserDefault synchronize];
}

+(NSArray *)getAllForeigncCurrencyFuturesInfo{
    
    if ([TheMarktUserDefault objectForKey:AllForeignCurrencyFutures]) {
        return [TheMarktUserDefault objectForKey:AllForeignCurrencyFutures];
    }
    
    return @[];
}

+(void)saveAllForeignStockIndexFuturesInfo{
    
    NSArray *arr = @[@{@"NAS":@"纳斯达克指数期货"},@{@"ES":@"标准普尔指数期货"},@{@"DJS":@"道琼斯指数期货"},@{@"HSI":@"恒生指数期货"}];
    
    [TheMarktUserDefault setObject:arr forKey:AllForeignStockIndexFutures];
    [TheMarktUserDefault synchronize];
}

+(NSArray *)getAllForeignStockIndexFuturesInfo{
    
    if ([TheMarktUserDefault objectForKey:AllForeignStockIndexFutures]) {
        return [TheMarktUserDefault objectForKey:AllForeignStockIndexFutures];
    }
    
    return @[];
}

+(void)saveAllForeigncCurrencyFuturesInfo{
    
    NSArray *arr = @[@{@"DXF":@"美元指数期货"},@{@"SF":@"瑞郎期货"},@{@"CD":@"加元期货"},@{@"JY":@"日元期货"},@{@"BP":@"英镑期货"},@{@"EC":@"欧元期货"}];
    
    [TheMarktUserDefault setObject:arr forKey:AllForeignCurrencyFutures];
    [TheMarktUserDefault synchronize];
}

+(BOOL)getCodeIsDomestic:(NSString *)code{
    
    if ([TheMarktUserDefault objectForKey:AllForeignGoodsFutures] && [TheMarktUserDefault objectForKey:AllForeignStockIndexFutures] && [TheMarktUserDefault objectForKey:AllForeignCurrencyFutures]) {
        
        NSDictionary *dic = [TheMarktUserDefault objectForKey:AllForeignGoodsFutures];
        
        NSArray *arr1 = [TheMarktUserDefault objectForKey:AllForeignStockIndexFutures];
        
        NSArray *arr2 = [TheMarktUserDefault objectForKey:AllForeignCurrencyFutures];
        
        __block BOOL isGuonei = YES;
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSArray *arr in dic.allValues) {
            
            for (NSDictionary *tempDic in arr) {
                [temp addObject:tempDic.allKeys.firstObject];
                
            }
        }
        for (NSDictionary *tempDic in arr1) {
            [temp addObject:tempDic.allKeys.firstObject];
        }
        for (NSDictionary *tempDic in arr2) {
            [temp addObject:tempDic.allKeys.firstObject];
        }
        
        [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([code.uppercaseString isEqualToString:obj]) {
                isGuonei = NO;
                *stop = YES;
            }
        }];
        
        return isGuonei;
    }else{
        return YES;
    }
}

+(BOOL)isLogin{
    
    if ([TheMarktUserDefault objectForKey:@"save_userinfor"]) {
        return [[TheMarktUserDefault objectForKey:@"save_userinfor"] boolValue];
    }else{
        return NO;
    }
}

+(NSString *)getNowLoginInfo{
    
    if ([TheMarktUserDefault objectForKey:@"loginnumber"]) {
        return [TheMarktUserDefault objectForKey:@"loginnumber"];
    }
    
    return @"";
}

@end
