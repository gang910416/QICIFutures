

#import "QCMarketLogic.h"
#import "OrderBookModel.h"

@implementation QCMarketLogic

/* 市场名称 */
+ (NSArray <NSString *> *)getMarketNames {
    
//    return @[@"沪股",@"深股",@"美股",@"港股",@"自选"];
    return @[@"自选",@"金属",@"黄金白银ETF",@"能源",@"农产品"];
}

/**
 期货symbols
 */
+ (NSDictionary *)getFutureMarketSymbols {
    
    NSDictionary *symbols = @{
                              @"金属":@[@"XAUUSD.OTC",@"XAGUSD.OTC",@"USGC.OTC",@"USSI.OTC",@"USPL.OTC",@"USPA.OTC",@"USHG.OTC",@"AUTD.SGE",@"AGTD.SGE",@"AU100G.SGE",@"AU9995.SGE",@"AU9999.SGE",@"mAUTD.SGE",@"PT9995.SGE",@"UKCA.OTC",@"UKAH.OTC",@"UKNI.OTC",@"UKPB.OTC",@"UKSN.OTC",@"UKZS.OTC"],
                              @"黄金白银ETF":@[@"GLD.NYSEArca",@"IAU.NYSEArca",@"DBP.NYSEArca",@"GDX.NYSEArca",@"PSAU.NASD",@"SLV.NYSEArca",@"DBS.NYSEArca"],
                              @"能源":@[@"UKOIL.OTC",@"USCL.OTC",@"USNG.OTC"],
                              @"农产品":@[@"USYO.OTC",@"USZC.OTC",@"USZS.OTC",@"USZW.OTC"]
                              };
    
    return symbols;
}

/**
 根据市场获得期货的symbols

 @param identifer 市场的标识
 */
+ (NSArray <NSString *>*)getSymbolsWithMarketIdentifer:(NSString *)identifer {

    NSArray *symbols = @[];

    if (!isStrEmpty(identifer)) {
        NSDictionary *dict = [self getFutureMarketSymbols];

        if (dict) {
            symbols = [dict objectForKey:identifer];
        }
    }
    return symbols;
}


/**
 根据周期获得所传参数的时间间隔
 
 @param timeType 时间周期(1日、1周)
 @return 时间间隔，1分=60，1日=86400
 */
+ (NSString *)getTimeInervalWithTimeType:(NSString *)timeType {
    
    NSDictionary *timeInfo = @{
                               @"分时":@"60",
                               @"1分":@"60",
                               @"5分":@"300",
                               @"15分":@"900",
                               @"30分":@"1800",
                               @"1时":@"3600",
                               @"1日":@"86400",
                               @"1周":@"604800",
                               @"1月":@"2592000"
                               };
    
    NSString *ret = [timeInfo objectForKey:timeType];
    
    if (isStrEmpty(ret) || [ret integerValue] < 60) {
        ret = @"60";
    }
    
    return ret;
}

/**
 搜索股票
 
 @param symbol 股票代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)searchStockDataWithSymbol:(NSString *)symbol success:(void (^)(NSArray <ASDMarketListModel *> * searchList))suc faild:(void (^)(NSError *error))faild {
    
    NSString *path = @"real";
    
    NSString *fields = [HOMEBACKDATA componentsJoinedByString:@","];
    
    NSDictionary *params = @{@"token":APPKEY51,@"prod_code":symbol ? : @"",@"fields":fields};
    
    [[QICIHTTPRequest sharedInstance] oneGet:DATAURL51 path:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *list = @[];
        
        if (responseObject) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            if (data && data.count > 0 && [data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *snapShot = [data objectForKey:@"snapshot"];
                
                list = [QCHomeDataMannger processMarketModelWithDicitionay:snapShot];
            }
        }
        
        !suc ? : suc(list);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !faild ? : faild(error);
    }];
}


#pragma mark - 期货相关 --

/**
 获得期货市场的列表
 
 @param codes 期货代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)futureMarketListDataWithCodes:(NSString *)codes market:(NSString *)marketName success:(void(^) (NSArray <ASDMarketListModel *>* list))suc faild:(void (^)(NSError *))faild {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    
    NSString *fields = [HOMEBACKDATA componentsJoinedByString:@","];
    
    [params setObject:fields forKey:@"fields"];
    [params setObject:APPKEY51 forKey:@"token"];
    [params setObject:!isStrEmpty(codes) ? codes : @"" forKey:@"prod_code"];
    
    [[QICIHTTPRequest sharedInstance] oneGet:DATAURL51 path:@"real" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *list = @[];
        
        if (responseObject) {

            NSDictionary *data = [responseObject objectForKey:@"data"];
            if (data && data.count > 0) {
                NSDictionary *snap = [data objectForKey:@"snapshot"];
                
                list = [[self p_processWithSnap:snap market:marketName] mutableCopy];
            }
        }
        !suc ? : suc(list ? : @[]);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !faild ? : faild(error);
    }];
}

/**
 获得股票K线数据
 
 @param market  股票市场
 @param symbol 股票代码
 @param timeInterval K线周期
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)futureGetKlineDateWithMarket:(NSString *)market symbol:(NSString *)symbol timeType:(NSString *)timeInterval success:(void (^)(NSArray <KLineModel *> * klineArray))suc faild:(void (^)(NSError *error))faild {
    
    NSDictionary *params = @{@"token":APPKEY51,@"prod_code":symbol ? : @"",@"period_type":timeInterval ? : @"",@"tick_count":@"600",@"fields":@"tick_at,open_px,close_px,high_px,low_px,turnover_volume"};
    
    [[QICIHTTPRequest sharedInstance] oneGet:DATAURL51 path:@"kline" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *klineArray = @[].mutableCopy;
        if (responseObject) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            if (data && data.count > 0) {
                NSDictionary *candle = [data objectForKey:@"candle"];
                NSDictionary *stockData = [candle objectForKey:symbol];
                NSArray *tempArray = [stockData objectForKey:@"lines"];
                
                for(int i = 0; i < tempArray.count ;i ++) {
                    
                    NSArray *tempLineArray = [tempArray objectAtIndex:i];
//                    KLineModel *model = [KLineModel createWithArray:tempLineArray];
//                    [klineArray addObject:model];
                }
            }
        }
        
        !suc ? : suc(klineArray);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !faild ? : faild(error);
    }];
}

#pragma mark - 私有方法 --


+ (NSArray <ASDMarketListModel *>*)p_processWithSnap:(NSDictionary *)snap market:(NSString *)marketName {
    
    NSMutableArray *tempList = @[].mutableCopy;
    
    if (snap && snap.count > 0) {
        
        NSArray *keys = [snap allKeys];
        
        for (NSString *tempKey in keys) {
            NSArray *dataArray = [snap objectForKey:tempKey];
            
            QICIMarkeModel *tempModel = [QICIMarkeModel createModelWithArray:dataArray];
            
            tempModel.marketName = marketName;
            
            [tempList addObject:tempModel];
        }
    }
    return tempList;
}


+ (NSDictionary *)p_createOrderBookModelFromData:(NSDictionary *)data {
    NSDictionary *lists = @{@"buy":@[],@"sell":@[]};
    if (data && [data isKindOfClass:[NSDictionary class]] && data.count > 0) {
        NSMutableArray *buyList = @[].mutableCopy;
        [buyList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"buyOnePri"] amount:[data objectForKey:@"buyOne"] isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"buyTwoPri"] amount:[data objectForKey:@"buyTwo"] isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"buyThreePri"] amount:[data objectForKey:@"buyThree"] isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"buyFourPri"] amount:[data objectForKey:@"buyFour"] isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"buyFivePri"] amount:[data objectForKey:@"buyFive"] isAsk:NO]];
        
        NSMutableArray *sellList = @[].mutableCopy;
        [sellList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"sellOnePri"] amount:[data objectForKey:@"sellOne"] isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"sellTwoPri"] amount:[data objectForKey:@"sellTwo"] isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"sellThreePri"] amount:[data objectForKey:@"sellThree"] isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"sellFourPri"] amount:[data objectForKey:@"sellFourPri"] isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:[data objectForKey:@"sellFivePri"] amount:[data objectForKey:@"sellFive"] isAsk:YES]];
        
        lists = @{@"buy":buyList,@"sell":sellList};
    }else {
        
        NSMutableArray *buyList = @[].mutableCopy;
        [buyList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:NO]];
        
        NSMutableArray *sellList = @[].mutableCopy;
        [sellList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[OrderBookModel createModelWithPrice:nil amount:nil isAsk:YES]];
        
        lists = @{@"buy":buyList,@"sell":sellList};
    }
    
    return lists;
}

@end
