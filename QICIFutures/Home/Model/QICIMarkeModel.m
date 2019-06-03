//
//  QICIMarkeModel.m
//  QICIFutures
//
//  Created by mac on 2019/5/31.
//

#import "QICIMarkeModel.h"

@implementation QICIMarkeModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

+ (instancetype)createModelWithArray:(NSArray *)array{
    QICIMarkeModel *model = nil;
    if (array && array.count >=  15) {
        model = [[QICIMarkeModel alloc] init];
        model.prod_name = array[0];
        model.prod_code = array[1];
        model.last_px = [NSString stringWithFormat:@"%@",array[2]];
        model.px_change = [NSString stringWithFormat:@"%@",array[3]];
        model.px_change_rate = [NSString stringWithFormat:@"%@",array[4]];
        model.open_px = [NSString stringWithFormat:@"%@",array[5]];
        model.high_px = [NSString stringWithFormat:@"%@",array[6]];
        model.low_px = [NSString stringWithFormat:@"%@",array[7]];
        model.preclose_px = [NSString stringWithFormat:@"%@",array[8]];
        model.bid_grp = [NSString stringWithFormat:@"%@",array[9]];
        model.offer_grp = [NSString stringWithFormat:@"%@",array[10]];
        model.week_52_low = [NSString stringWithFormat:@"%@",array[11]];
        model.week_52_high = [NSString stringWithFormat:@"%@",array[12]];
        model.trade_status = [NSString stringWithFormat:@"%@",array[13]];
        model.update_time = [NSString stringWithFormat:@"%@",array[14]];
    }
    return model;
}

-(NSString *)market_type{
    if (!_market_type) {
        _market_type = @"";
    }
    return _market_type;
}
- (NSString *)marketName {
    if (!_marketName) {
        _marketName = @"";
    }
    return _marketName;
    
}


- (NSString *)tradeState {
    
    _tradeState = @"--";
    
    if (!isStrEmpty(self.trade_status)) {
        if ([self.trade_status isEqualToString:@"TRADE"]) {
            _tradeState = @"交易中";
        }else if([self.trade_status isEqualToString:@"BREAK"]) {
            
            _tradeState = @"休市";
        }else if([self.trade_status isEqualToString:@"ENDTR"]) {
            
            _tradeState = @"交易结束";
        }else if([self.trade_status isEqualToString:@"PRETR"]) {
            
            _tradeState = @"盘前";
        }else if([self.trade_status isEqualToString:@"HALT"]) {
            
            _tradeState = @"停盘";
        }else if([self.trade_status isEqualToString:@"START"]) {
            
            _tradeState = @"市场启动";
        }else if([self.trade_status isEqualToString:@"STOPT"]) {
            
            _tradeState = @"长期停盘";
        }else if([self.trade_status isEqualToString:@"OCALL"]) {
            
            _tradeState = @"集合竞价";
        }else if([self.trade_status isEqualToString:@"SUSP"]) {
            
            _tradeState = @"停盘";
        }else if([self.trade_status isEqualToString:@"POSIT"]) {
            
            _tradeState = @"退盘后";
        }else if([self.trade_status isEqualToString:@"DELISTED"]) {
            
            _tradeState = @"退市";
        }
    }
    
    return _tradeState;
}




@end
