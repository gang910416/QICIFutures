//
//  QICIMarkeModel.h
//  QICIFutures
//
//  Created by mac on 2019/5/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QICIMarkeModel : NSObject<NSCopying>
@property (strong, nonatomic) NSString *prod_name;      // 名称
@property (strong, nonatomic) NSString *prod_code;      // code
@property (strong, nonatomic) NSString *last_px;        // 最后成交价
@property (strong, nonatomic) NSString *px_change;      // 涨跌幅
@property (strong, nonatomic) NSString *px_change_rate; // 涨跌率
@property (strong, nonatomic) NSString *open_px;        // 开盘价
@property (strong, nonatomic) NSString *high_px;        // 最高价
@property (strong, nonatomic) NSString *low_px;         // 最低价
@property (strong, nonatomic) NSString *bid_grp;        // 委买
@property (strong, nonatomic) NSString *offer_grp;      // 委卖
@property (strong, nonatomic) NSString *preclose_px;        // 昨收价
@property (strong, nonatomic) NSString *week_52_low;        // 52周最低价
@property (strong, nonatomic) NSString *week_52_high;       // 52周最高价
@property (strong, nonatomic) NSString *trade_status;       // 交易状态
@property (strong, nonatomic) NSString *update_time;        // 更新时间
#pragma mark - 扩展 --
/** 市场代码 */
@property (strong, nonatomic) NSString *market_type;

/** 市场名称 */
@property (strong, nonatomic) NSString *marketName;

/** 当前交易状态 */
@property (strong, nonatomic) NSString *tradeState;

+ (instancetype)createModelWithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
