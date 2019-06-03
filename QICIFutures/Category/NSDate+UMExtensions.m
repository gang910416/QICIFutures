//
//  NSDate+UMExtensions.m
//  uoumei
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 um. All rights reserved.
//


#import "NSDate+UMExtensions.h"
static NSDictionary *weakDayStringDic = nil;

@implementation NSDate (UMExtensions)

- (NSDate *)um_dateByAddingMonth:(NSInteger)months
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = months;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)um_dateByAddingDay:(NSInteger)days
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)um_dateByAddingMinute:(NSInteger)minute
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.minute = minute;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSString *)um_weekDayString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakDayStringDic = @{@1:@"周日",
                             @2:@"周一",
                             @3:@"周二",
                             @4:@"周三",
                             @5:@"周四",
                             @6:@"周五",
                             @7:@"周六"};
    });
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitWeekday
                                                                       fromDate:self];
    return weakDayStringDic[@(dateComponents.weekday)];
}

- (NSInteger)um_year
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                       fromDate:self];
    return dateComponents.year;
    
}

- (NSInteger)um_month
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth
                                                                       fromDate:self];
    return dateComponents.month;
    
}

- (NSInteger)um_day
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                                       fromDate:self];
    return dateComponents.day;
}

- (NSInteger)um_hour
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour
                                                                       fromDate:self];
    return dateComponents.hour;
}

- (NSInteger)um_minute
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute
                                                                       fromDate:self];
    return dateComponents.minute;
}

- (NSInteger)um_second
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
                                                                       fromDate:self];
    return dateComponents.second;
}

+ (long long)um_dateStampFrom1970
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    return time;
};

+ (NSDate *)um_dateFromNormalDateString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    dateFormatter = nil;
    
    return destDate;
}

+ (NSDate *)um_dateFromDateString:(NSString *)dateString withFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: dateFormat];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    dateFormatter = nil;
    
    return destDate;
}

- (NSString *)um_stringFromNormalDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

- (NSString *)um_stringFromDateWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

- (BOOL)um_isEarlierThan:(NSDate *)date
{
    if (self.timeIntervalSince1970 < date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

- (BOOL)um_isEarlierThanOrEqualTo:(NSDate *)date
{
    if (self.timeIntervalSince1970 <= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

- (BOOL)um_isLaterThan:(NSDate *)date
{
    if (self.timeIntervalSince1970 > date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

- (BOOL)um_isLaterThanOrEqualTo:(NSDate *)date
{
    if (self.timeIntervalSince1970 >= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

+ (NSString *)um_getDateStringWithTimeStr:(NSTimeInterval)timeInterval
                             formatString:(NSString *)formatString
{
    NSTimeInterval time = timeInterval/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatString];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

@end
