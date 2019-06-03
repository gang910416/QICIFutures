//
//  NSString+NumberFormatter.h
//  kkcoin
//
//  Created by kk_ghostlord on 2018/3/23.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (NumberFormatter)

/**
 根据服务器传来的资产数据转换成展示的数据，整数部分使用","分割
 例如：NSString *numStr = [NSString convertToDisplayStringWithOriginNum:@"4624671262.46720089" decimalsLimit:3 suffix:@" CNY"];
 numStr = @"4，624，671，262.467 CNY"
 
 @param numString 原始数据
 @param prefix 前缀
 @param suffix 后缀
 @param decimal 小数位数限制: <0 代表不生效
 @return 转换后的字符串
 */
+ (NSString * _Nullable)gl_convertToDisplayStringWithOriginNum:(NSString * _Nonnull)numString decimalsLimit:(NSInteger)decimal prefix:(NSString *_Nullable)prefix suffix:(NSString * _Nullable)suffix;

/**
 修复数字字符串的小数位数限制

 @param numString 数字字符串
 @param minDecimal 最小小数位数限制
 @param maxDecimal 最大小数位数限制
 */
+ (NSString * _Nullable)gl_fixNumString:(NSString * _Nonnull)numString minDecimalsLimit:(NSInteger)minDecimal maxDecimalsLimit:(NSInteger)maxDecimal;

/* 将字符串转换为小数对象 */
- (NSDecimalNumber *)gl_digitalValue;


/**
 大数字的格式化

 @param numString 需要格式化的数字
 @param decimal 小数位数
 @param unit 分割的单位
 @param prefix 前缀
 @param suffix 后缀
 @return 格式化后的文字
 */
- (NSString *)gl_formetterBigNumber:(NSString *)numString decimalsLimit:(NSInteger)decimal separatorUnit:(NSInteger)unit prefix:(NSString *)prefix suffix:(NSString *_Nullable)suffix;

@end
NS_ASSUME_NONNULL_END
