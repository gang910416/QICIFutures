//
//  ServerManager.m
//  kkcoin
//
//  Created by walker on 2018/10/23.
//  Copyright © 2018 KKCOIN. All rights reserved.
//

#import "GLServerManager.h"

#define KKServerListPath [KK_FilePath_ServerList stringByAppendingString:[NSDictionary kk_getCurrentVersion]]

@interface GLServerManager ()

/** 当前的服务器列表 */
@property (strong, nonatomic) NSMutableArray <ServerModel *>*serverList;

/** 当前最优的服务器模型 */
@property (strong, nonatomic, readwrite) ServerModel *optimalServer;

/**  当前服务器类型 */
@property (assign, nonatomic, readwrite) ServerType currentServerType;

@end

@implementation GLServerManager

#pragma mark - 单例相关 -----begin---
/*
 创建静态对象 防止外部访问
 */
static GLServerManager *_manager;

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
            _manager.isAvail = YES;
            //            [_manager p_connectServerLoop];     // 定时器
        }
    });
    return _manager;
}

/**
 初始化单例
 
 @return Socket管理中心单例
 */
+ (instancetype)manager
{
    return [[self alloc]init];;
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

/**
 切换服务器类型
 
 @param serverType 服务器类型
 */
- (void)switchServerType:(ServerType)serverType {
    
    if (serverType) {
        self.currentServerType = serverType;
        
        switch (self.currentServerType) {
            case DevServer:
            {
                [self p_setDevServer];
            }
                break;
                
            case TestServer:
            {
                [self p_setTestServer];
            }
                break;
                
            case DisServer:
            {
                [self p_initDisServerManager];
            }
                break;
                
            default:
            {
                [self p_initDisServerManager];
            }
                break;
        }
        
    }else {
        self.currentServerType = DisServer;
        [self p_initDisServerManager];
    }
}

/**
 获得当前的服务器列表
 
 @return 所有的服务器列表
 */
- (NSArray <ServerModel *>*)getCurrentServerList {
    
    return [NSArray arrayWithArray:self.serverList];
}

#pragma mark - 私有方法 --

- (void)p_initDisServerManager {
    
    [self.serverList removeAllObjects];
    ServerModel *model = [[ServerModel alloc] init];
    model.baseApiUrl_juhe = @"http://web.juhe.cn:8080/finance/stock/";
    model.appkey_juhe = @"91c87ae2a532d600890c46f244c86ed1";
    model.baseApiUrl_51 = @"http://data.api51.cn/apis/integration/";
    model.appkey_51 = @"3f39051e89e1cea0a84da126601763d8";
    model.baseApiUrl_jisu = @"https://api.jisuapi.com/";
    model.appkey_jisu = @"adafbc1138c6ff85";
    model.isAvailable = YES;
    
    [self.serverList addObject:model];
    self.optimalServer = model;
}

- (void)p_setDevServer {
    
    [self.serverList removeAllObjects];
    ServerModel *model = [[ServerModel alloc] init];
    model.baseApiUrl_juhe = @"http://web.juhe.cn:8080/finance/stock/";
    model.appkey_juhe = @"a42dfe112d2b82fe44906fa749281376";
    model.baseApiUrl_51 = @"http://data.api51.cn/apis/integration/";
    model.appkey_51 = @"3f39051e89e1cea0a84da126601763d8";
    model.baseApiUrl_jisu = @"https://api.jisuapi.com/";
    model.appkey_jisu = @"adafbc1138c6ff85";
    model.isAvailable = YES;
    
    [self.serverList addObject:model];
    self.optimalServer = model;
}

- (void)p_setTestServer {
    
    [self.serverList removeAllObjects];
    ServerModel *model = [[ServerModel alloc] init];
    model.baseApiUrl_juhe = @"http://web.juhe.cn:8080/finance/stock/";
    model.appkey_juhe = @"a42dfe112d2b82fe44906fa749281376";
    model.baseApiUrl_51 = @"http://data.api51.cn/apis/integration/";
    model.appkey_51 = @"3f39051e89e1cea0a84da126601763d8";
    model.baseApiUrl_jisu = @"https://api.jisuapi.com/";
    model.appkey_jisu = @"adafbc1138c6ff85";
    model.isAvailable = YES;
    
    [self.serverList addObject:model];
    self.optimalServer = model;
}

#pragma mark - 懒加载 --

- (NSMutableArray<ServerModel *> *)serverList {
    if (!_serverList) {
        _serverList = @[].mutableCopy;
    }
    return _serverList;
}


@end

@implementation ServerModel

- (NSString *)description
{
    return [self yy_modelDescription];
}

- (NSDictionary *)getInfoDict {
    
    NSDictionary *dict = @{
//                           @"testHost":self.testHost ? : @"",
//                           @"wssTdUrl":self.wssTdUrl ? : @"",
//                           @"baseUrl":self.baseUrl ? : @"",
//                           @"wssUrl":self.wssUrl ? : @"",
//                           @"webUrl":self.webUrl ? : @"",
//                           @"ping":self.ping ? : @(0.0f),
//                           @"isAvailable":@(self.isAvailable),
//                           @"isCanPing":@(self.isCanPing),
//                           @"lastTestPings":self.lastTestPings
                           };
    return dict ? : @{};
}

@end
