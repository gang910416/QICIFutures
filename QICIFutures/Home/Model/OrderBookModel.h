

#import <Foundation/Foundation.h>

@interface OrderBookModel : NSObject


/** 是否是ASK */
@property (assign, nonatomic) BOOL isAsk;

/** 价格 */
@property (strong, nonatomic) NSString *price;

/** 数量 */
@property (strong, nonatomic) NSString *amount;

/**
 获得数量

 @param decimal 小数位数限制
 @param unitAmount 单位
 @return 计算后的数量
 */
- (NSDecimalNumber *)getCountWithDecimal:(NSInteger)decimal unitAmount:(CGFloat)unitAmount;

/**
 获得金额

 @param decimal 小数位数限制
 @return 计算后的金额
 */
- (NSDecimalNumber *)getAmountWithDecimal:(NSInteger)decimal;


/**
 创建模型的快捷方法

 @param array 数据数组
 @param isAsk 是否是卖盘
 */
+ (instancetype)createModelWithDataArray:(NSArray *)array isAsk:(BOOL)isAsk;

/**
 创建模型的快捷方法
 
 @param price 价格
 @param amount  数量
 @param isAsk 是否是卖盘
 */
+ (instancetype)createModelWithPrice:(NSString *)price amount:(NSString *)amount isAsk:(BOOL)isAsk;

@end
