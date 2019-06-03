//
//  KLineModel.m
//  KLineDemo
//
//  Created by kk_ghostlord on 2018/4/28.
//  Copyright © 2018年 Ghostlrod. All rights reserved.
//

#import "KLineModel.h"
#import "DataCenter.h"
@implementation KLineModel

/**
 根据数据数组创建对象
 
 @param dataArray 数据数组
 */
+ (instancetype)createWithArray:(NSArray *)dataArray {
    KLineModel *tempModel = nil;
    
    for (int a = 0; a < dataArray.count; a ++) {
        
        tempModel = [KLineModel new];
        tempModel.open = [dataArray[0] doubleValue];
        tempModel.close = [dataArray[1] doubleValue];
        tempModel.high = [dataArray[2] doubleValue];
        tempModel.low = [dataArray[3] doubleValue];
        tempModel.volume = [dataArray[4] doubleValue];
        tempModel.stamp = [dataArray[5] doubleValue] * 1000;
    }
    
    return tempModel;
}


/**
 便捷初始化方法
 
 @param dictionary 数据字典
 */
+ (instancetype)createWithDictionary:(NSDictionary *)dictionary {
    
    KLineModel *tempModel = nil;
    
    if (dictionary && [dictionary count] > 0) {
        
        tempModel = [KLineModel new];
        tempModel.stamp = [[dictionary objectForKey:@"tick_at"] doubleValue];
        tempModel.open = [[dictionary objectForKey:@"open_px"] doubleValue];
        tempModel.close = [[dictionary objectForKey:@"close_px"] doubleValue];
        tempModel.high = [[dictionary objectForKey:@"high_px"] doubleValue];
        tempModel.low = [[dictionary objectForKey:@"low_px"] doubleValue];
        tempModel.volume = [[dictionary objectForKey:@"turnover_volume"] doubleValue];
    }
    
    return tempModel;
}

@end
