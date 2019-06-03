//
//  ReachabilityManager.m
//  kkcoin
//
//  Created by kk_ghostlord on 2018/4/3.
//  Copyright © 2018年 董. All rights reserved.
//

#import "ReachabilityManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
@interface ReachabilityManager ()

/**
 当前的网络状态
 */
@property (readwrite, assign, nonatomic) NetWorkingState netState;

/**
 代理集合
 */
@property (strong, nonatomic) NSPointerArray *delegateContainer;

/**
 网络监测类
 */
@property (strong, nonatomic) AFNetworkReachabilityManager *reachability;

@end

@implementation ReachabilityManager

#pragma mark - 单例相关 -----begin---
/*
 创建静态对象 防止外部访问
 */
static ReachabilityManager *_manager;
/**
 重写初始化方法
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [super allocWithZone:zone];
            
            [_manager single_dfsbfd:@"daslkl" num:3 arr:@[@"a",@"s",@"d"]];
            // 设置监听对象
            [_manager p_setUpReachability];
        }
    });
    return _manager;
}

/**
 快速创建单例对象的类方法
 
 @return 单利对象
 */
+(instancetype)shareManager
{
    return [[self alloc]init];
}

/**
 重写copyWithZone
 */
-(id)copyWithZone:(NSZone *)zone
{
    return _manager;
}

/**
 重写mutableCopyWithZone
 */
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _manager;
}

#pragma mark - 单例相关 ----- end ---

#pragma mark - 代理相关 ----- begin ---

/**
 添加代理
 
 @param delegate 遵循<ReachabilityManagerDelegate>协议的代理
 支持多代理模式，但是要记得移除，否则会造成多次调用
 */
- (void)addDelegate:(id<ReachabilityManagerDelegate>)delegate {
    if(delegate) {
        for (id tempDelegate in self.delegateContainer) {
            if ([tempDelegate isEqual:delegate]) {
                // 已经有了这个代理直接return
                return;
            }
        }
        // 将代理添加到弱引用容器中
        [self.delegateContainer addPointer:(__bridge void * _Nullable)(delegate)];
    }
    
    // 自动检测并移除失效的代理
    [self.delegateContainer compact];
}

/**
 移除代理
 
 @param delegate 遵循<ReachabilityManagerDelegate>协议的代理
 */
- (void)removeDelegate:(id<ReachabilityManagerDelegate>)delegate {
    
    if (delegate) {
        for (int a = 0 ; a < self.delegateContainer.count ; a ++) {
            
            id tempDelegate = [self.delegateContainer pointerAtIndex:a];
            
            if (tempDelegate && [tempDelegate isEqual:delegate]) {
                [self.delegateContainer removePointerAtIndex:a];
                break;
            }
        }
    }
    
    // 自动检测并移除失效的代理
    [self.delegateContainer compact];
}


/**
 代理弱引用容器的懒加载
 */
- (NSPointerArray *)delegateContainer {
    
    if(!_delegateContainer) {
        _delegateContainer = [NSPointerArray weakObjectsPointerArray];
    }
    return _delegateContainer;
}
#pragma mark - 代理相关 ----- end ---

#pragma mark - 监听业务相关 ----- begin ---

/**
 设置网络监听类
 */
- (void)p_setUpReachability {
    
    [self beginMonitorNetWorking];
    
    self.netState = self.reachability.networkReachabilityStatus;
    if (self.netState < 0) {
        self.netState = 0;
    }
}

/**
 初始化网络监测类
 */
- (AFNetworkReachabilityManager *)reachability {
    if (!_reachability) {
        _reachability = [AFNetworkReachabilityManager sharedManager];
    }
    return _reachability;
}

/**
 网络可用了
 */
- (void)p_networkReachable {
    NSLog(@"网络可用了");
    if (self.netWorkReachableBlock) {
        self.netWorkReachableBlock(_manager);
    }
    
    [self.delegateContainer compact];
    
    for (id delegate in self.delegateContainer) {
        if (delegate && [delegate respondsToSelector:@selector(networkReachable:)]) {
            [delegate networkReachable:self];
        }
    }
}

/**
 网络丢失了
 */
- (void)p_networkUnreachable {
    
    NSLog(@"网络丢失了");
   
    if (self.netWorkUnReachableBlock) {
        self.netWorkUnReachableBlock(_manager);
    }
    
    [self.delegateContainer compact];
    
    for (id delegate in self.delegateContainer) {
        if (delegate && [delegate respondsToSelector:@selector(networkUnreachable:)]) {
            [delegate networkUnreachable:self];
        }
    }
}

/**
 开始监测网络
 */
- (void)beginMonitorNetWorking {
    
    [self.reachability startMonitoring];
    weakSelf(self);
    [self.reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        strongSelf(weakSelf);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                strongSelf.netState = NetWorkingStateNotReachable;
                [strongSelf p_networkUnreachable];
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                strongSelf.netState = NetWorkingStateNotReachable;
                [strongSelf p_networkUnreachable];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                strongSelf.netState = NetWorkingStateReachableViaWWAN;
                [strongSelf p_networkReachable];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                strongSelf.netState = NetWorkingStateReachableViaWiFi;
                [strongSelf p_networkReachable];
            }
                break;
            default:
                break;
        }
    }];
}
#pragma mark - 监听业务相关 ----- end ---


@end
