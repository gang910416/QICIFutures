//
//  FuturesKModel.h
//  QCLC
//
//  Created by mac on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuturesKModel : NSObject

/**
 现价
 */
@property (nonatomic,copy) NSString *close;

/**
 日期时间
 */
@property (nonatomic,copy) NSString *date;

/**
 最高
 */
@property (nonatomic,copy) NSString *high;

/**
 最低
 */
@property (nonatomic,copy) NSString *low;

/**
 开盘
 */
@property (nonatomic,copy) NSString *open;

/**
 成交量
 */
@property (nonatomic,copy) NSString *volume;

@property (nonatomic,copy) NSString *ma5;

@property (nonatomic,copy) NSString *ma10;

@property (nonatomic,copy) NSString *ma20;

@end

NS_ASSUME_NONNULL_END
