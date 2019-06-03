//
//  NSDate+UMExtensions.h
//  uoumei
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 um. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UMExtensions)

/**
 *  计算日期是哪一天
 *
 *  @return 天数
 */
- (NSInteger)um_day;

/**
 *  计算日期是星期几
 *
 *  @return 周几
 */
- (NSString *)um_weekDayString;

/**
 *  计算日期是哪一月
 *
 *  @return 月份
 */
- (NSInteger)um_month;

/**
 *  计算日期是哪一年
 *
 *  @return 年份
 */
- (NSInteger)um_year;

/**
 *  计算日期是哪一小时
 *
 *  @return 小时
 */
- (NSInteger)um_hour;

/**
 *  计算日期是哪一分钟
 *
 *  @return 分钟
 */
- (NSInteger)um_minute;

/**
 *  计算日期是哪一秒
 *
 *  @return 秒
 */
- (NSInteger)um_second;

/**
 *  获取增加自定义天数后的日期
 *
 *  @param days 自定义天数
 *
 *  @return (日期)NSDate对象
 */
- (NSDate *)um_dateByAddingDay:(NSInteger)days;

/**
 *  获取增加自定义月数后的日期
 *
 *  @param months 自定义月数
 *
 *  @return (日期)NSDate对象
 */
- (NSDate *)um_dateByAddingMonth:(NSInteger)months;

/**
 *  获取增加自定义分钟后的日期
 *
 *  @param minute 自定义分钟
 *
 *  @return (日期)NSDate对象
 */
- (NSDate *)um_dateByAddingMinute:(NSInteger)minute;

/**
 *  返回1970年以来的时间戳
 *
 *  @return 1970年以来的时间戳
 */
+ (long long)um_dateStampFrom1970;

/**
 *  使用日期字符串初始化NSDate对象(默认格式: @"yyyy-MM-dd HH:mm:ss")
 *
 *  @param dateString 日期字符串
 *
 *  @return (日期)NSDate对象
 */
+ (NSDate *)um_dateFromNormalDateString:(NSString *)dateString;

/**
 *  将日期字符串初始化NSDate对象(使用自定义日期格式)
 *
 *  @param dateString 日期字符串
 *
 *  @param dateFormat 日期格式(与字符串一致) 如：字符串：@"2016-04-25 17:31", 则格式：@"yyyy-MM-dd HH:mm"
 *
 *  @return (日期)NSDate对象
 */
+ (NSDate *)um_dateFromDateString:(NSString *)dateString withFormat:(NSString *)dateFormat;

/**
 *  将NSDate对象转化为日期字符串(默认格式: @"yyyy-MM-dd HH:mm:ss")
 *
 *  @return 日期字符串
 */
- (NSString *)um_stringFromNormalDate;

/**
 *  将NSDate对象转化为日期字符串(使用自定义日期格式)
 *
 *  @param dateFormat 日期格式 如：@"yyyy-MM-dd HH:mm"
 *
 *  @return 日期字符串
 */
- (NSString *)um_stringFromDateWithFormat:(NSString *)dateFormat;

/**
 *  当前日期是否早于指定日期
 *
 *  @param date 指定日期
 *
 *  @return 是否早于
 */
- (BOOL)um_isEarlierThan:(NSDate *)date;

/**
 *  当前日期是否早于或者等于指定日期
 *
 *  @param date 指定日期
 *
 *  @return 是否早于或者等于
 */
- (BOOL)um_isEarlierThanOrEqualTo:(NSDate *)date;

/**
 *  当前日期是否晚于指定日期
 *
 *  @param date 指定日期
 *
 *  @return 是否晚于
 */
- (BOOL)um_isLaterThan:(NSDate *)date;

/**
 *  当前日期是否晚于或者等于指定日期
 *
 *  @param date 指定日期
 *
 *  @return 是否晚于或者等于
 */
- (BOOL)um_isLaterThanOrEqualTo:(NSDate *)date;

/**
 *  时间戳 -> yyyy-MM-dd字符串
 *
 *  @param timeInterval 时间戳
 *
 *  @return yyyy-MM-dd
 */
+ (NSString *)um_getDateStringWithTimeStr:(NSTimeInterval)timeInterval
                             formatString:(NSString *)formatString;

@end
