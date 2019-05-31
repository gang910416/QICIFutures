//
//  UMTimeStamp.h
//  uoumei
//
//  Created by liyongfei on 2018/6/1.
//  Copyright © 2018年 um. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTimeStamp : NSObject


#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

+(NSString*)getCurrentTimes;
+(NSString *)getChineseTime:(NSString *)time;
+ (NSString *)getweekDayString;

+(NSString *)getEnglishTime:(NSString *)time;

+(NSString *)getEnglishTime;
@end
