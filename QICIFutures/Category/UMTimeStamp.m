//
//  UMTimeStamp.m
//  uoumei
//
//  Created by liyongfei on 2018/6/1.
//  Copyright © 2018年 um. All rights reserved.
//

#import "UMTimeStamp.h"

@implementation UMTimeStamp
#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];

    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];

    return timeSp;
    
}

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
//    [formatter setDateFormat:@"dd-MM-yyyy-hh-mm"];
    // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
}
//获取当前的时间
#define DateFormatter @"yyyy年MM月dd日"

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:DateFormatter];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
//    NSArray *timeStrArr = [currentTimeString componentsSeparatedByString:@"-"];
//    NSString *time = [NSString stringWithFormat:@"%@年"]
    return currentTimeString;
    
    
}

+(NSString *)getChineseTime:(NSString *)time
{
    
    NSArray *strArr = [time componentsSeparatedByString:@"-"];
    
    
    NSString *str = [NSString stringWithFormat:@"%@年%@月%@日",strArr[0],strArr[1],strArr[2]];
    
    return str;
}

+ (NSString *) getweekDayString
{
    NSDate *date = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    
    NSNumber * weekNumber = @([comps weekday]);
    
    NSInteger weekInt = [weekNumber integerValue];
    
    NSString *weekDayString = @"";
    switch (weekInt) {
        case 1:
        {
            weekDayString = @"星期日";
        }
            break;
        case 2:
        {
            weekDayString = @"星期一";
        }
            break;
        case 3:
        {
            weekDayString = @"星期二";
        }
            break;
        case 4:
        {
            weekDayString = @"星期三";
        }
            break;
        case 5:
        {
            weekDayString = @"星期四";
        }
            break;
        case 6:
        {
            weekDayString = @"星期五";
        }
            break;
        case 7:
        {
            weekDayString = @"星期六";
        }
            break;
        default:
            break;
    }
    return weekDayString;
}

+(NSString *)getEnglishTime:(NSString *)time
{
    NSArray *strArr = [time componentsSeparatedByString:@":"];
    
    NSString *yString = strArr[0];
    NSString *mString = [self chineseToEnglish:strArr[1]];
    NSString *dString = strArr[2];
    NSString *string = [NSString stringWithFormat:@"%@ %@.%@",dString,mString,yString];
    return string;
}
+(NSString *)getEnglishTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"yyyy:MM:dd"];

    NSDate *datenow = [NSDate date];

    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSArray *strArr = [currentTimeString componentsSeparatedByString:@":"];
    
    NSString *yString = strArr[0];
    NSString *mString = [self chineseToEnglish:strArr[1]];
    NSString *dString = strArr[2];
    NSString *string = [NSString stringWithFormat:@"%@ %@.%@",dString,mString,yString];
    return string;
}
+ (NSString *)chineseToEnglish:(NSString *)string
{
    NSDictionary * dict = @{
                            @"01":@"Jan",
                            @"02":@"Feb",
                            @"03":@"Mar",
                            @"04":@"Apr",
                            @"05":@"May",
                            @"06":@"Jun",
                            @"07":@"Jul",
                            @"08":@"Aug",
                            @"09":@"Sep",
                            @"10":@"Oct",
                            @"11":@"Nov",
                            @"12":@"Dec"
                            };
    
    return [dict objectForKey:string];
}
@end
