

#import "OrderBookModel.h"

@implementation OrderBookModel


/**
 创建模型的快捷方法
 
 @param array 数据数组
 @param isAsk 是否是卖盘
 */
+ (instancetype)createModelWithDataArray:(NSArray *)array isAsk:(BOOL)isAsk {
    
    OrderBookModel *tempModel = [[OrderBookModel alloc] init];
    if (array && array.count >= 2) {
        tempModel.price = array[0];
        tempModel.amount = array[1];
    }
    tempModel.isAsk = isAsk;
    
    return tempModel;
}

/**
 创建模型的快捷方法
 
 @param price 价格
 @param amount  数量
 @param isAsk 是否是卖盘
 */
+ (instancetype)createModelWithPrice:(NSString *)price amount:(NSString *)amount isAsk:(BOOL)isAsk {
    
    OrderBookModel *tempModel = [[OrderBookModel alloc] init];
    
    if (!isStrEmpty(price)) {
        tempModel.price = price;
    }else {
        tempModel.price = @"--";
    }
    
    if (!isStrEmpty(amount)) {
        tempModel.amount = amount;
    }else {
        tempModel.amount = @"--";
    }
    
    tempModel.isAsk = isAsk;
    
    return tempModel;
    
}

/**
 获得数量
 
 @param decimal 小数位数限制
 @param unitAmount 单位
 */
- (NSDecimalNumber *)getCountWithDecimal:(NSInteger)decimal unitAmount:(CGFloat)unitAmount {
    NSDecimalNumber *num = nil;
    NSDecimalNumber *amount = [self.amount gl_digitalValue];
    NSDecimalNumber *unitAmountNum = [@"1" gl_digitalValue];
    NSInteger scale = 0;
    
    if (unitAmount > 0) {
        unitAmountNum = [[NSDecimalNumber alloc] initWithFloat:unitAmount];
    }
    
    if (decimal > 0) {
        scale = decimal;
    }
    
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];

    num = [amount decimalNumberByDividingBy:unitAmountNum withBehavior:handler];
    
    return num;
}

/**
 获得金额
 
 @param decimal 小数位数限制
 @return 计算后的金额
 */
- (NSDecimalNumber *)getAmountWithDecimal:(NSInteger)decimal {
    NSDecimalNumber *num = nil;

    NSDecimalNumber *amount = [self.amount gl_digitalValue];
    NSDecimalNumber *price = [self.price gl_digitalValue];
    NSInteger scale = 0;
    
    if (decimal > 0) {
        scale = decimal;
    }
    
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:(decimal + 2) raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    num = [amount decimalNumberByMultiplyingBy:price withBehavior:handler];
    
    return num;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"price:%@,amount:%@", _price,_amount];
}

@end
