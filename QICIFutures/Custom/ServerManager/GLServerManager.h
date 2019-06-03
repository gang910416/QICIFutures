//
//  ServerManager.h
//  kkcoin
//
//  Created by walker on 2018/10/23.
//  Copyright © 2018 KKCOIN. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ServerModel;

typedef enum : NSUInteger {
    DevServer = 1,  // 开发服务器
    TestServer,     // 提测服务器
    DisServer,      // 生产服务器
} ServerType;

NS_ASSUME_NONNULL_BEGIN

@interface GLServerManager : NSObject

/** 当前最优的服务器模型 */
@property (strong, nonatomic, readonly) ServerModel *optimalServer;

/**  当前服务器类型 */
@property (assign, nonatomic, readonly) ServerType currentServerType;

/**  是否可用 */
@property (assign, nonatomic) BOOL isAvail;

/* 初始化单例类 */
+ (instancetype)manager;

/**
 切换服务器类型

 @param serverType 服务器类型
 */
- (void)switchServerType:(ServerType)serverType;

/**
 获得当前的服务器列表

 @return 所有的服务器列表
 */
- (NSArray <ServerModel *>*)getCurrentServerList;

@end

#pragma mark - 服务器模型 --
@interface ServerModel : NSObject

/** 聚合基本URL */
@property (strong, nonatomic) NSString *baseApiUrl_juhe;

/** 聚合appkey */
@property (strong, nonatomic) NSString *appkey_juhe;

/** 51基本URL */
@property (strong, nonatomic) NSString *baseApiUrl_51;
/** 51 token*/
@property (strong, nonatomic) NSString *appkey_51;

/* 急速基本url */
@property (strong, nonatomic) NSString *baseApiUrl_jisu;
/* 急速appkey */
@property (strong, nonatomic) NSString *appkey_jisu;

/**  是否可用 */
@property (assign, nonatomic) BOOL isAvailable;

/** 转换成字典 */
- (NSDictionary *)getInfoDict;
@end
NS_ASSUME_NONNULL_END
