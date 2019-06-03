//
//  ReachabilityManager.h
//  kkcoin
//
//  Created by kk_ghostlord on 2018/4/3.
//  Copyright © 2018年 董. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReachabilityManager;
@protocol ReachabilityManagerDelegate <NSObject>
@optional
/**
 网络变成可用
 
 @param manager 网络监测对象
 */
- (void)networkReachable:(ReachabilityManager *)manager;

/**
 网络丢失
 
 @param manager 网络监测对象
 */
- (void)networkUnreachable:(ReachabilityManager *)manager;

@end

typedef void(^ReachabilityManagerBlock)(ReachabilityManager *manager);

@interface ReachabilityManager : NSObject

/**
 当前的网络状态
 */
@property (readonly, assign, nonatomic) NetWorkingState netState;

/**
 网络变成可用的block
 备注：只响应最后一个赋值的block
 */
@property (copy, nonatomic) ReachabilityManagerBlock netWorkReachableBlock;

/**
 网络丢失的block
 备注：只响应最后一个赋值的block
 */
@property (copy, nonatomic) ReachabilityManagerBlock netWorkUnReachableBlock;

/**
 创建单例
 */
+ (instancetype)shareManager;

/**
 添加代理
 
 @param delegate 遵循<ReachabilityManagerDelegate>协议的代理
 支持多代理模式，但是要记得移除，否则会造成多次调用
 */
- (void)addDelegate:(id<ReachabilityManagerDelegate>_Nonnull)delegate;

/**
 移除代理
 
 @param delegate 遵循<ReachabilityManagerDelegate>协议的代理
 */
- (void)removeDelegate:(id<ReachabilityManagerDelegate>_Nonnull)delegate;

/**
 开始监测网络
 */
- (void)beginMonitorNetWorking;

@end
