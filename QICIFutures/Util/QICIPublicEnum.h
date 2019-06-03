

#ifndef ASDPublicEnum_h
#define ASDPublicEnum_h

/** 网络状态 */
typedef enum : NSUInteger {
    
    NetWorkingStateNotReachable = 0,
    NetWorkingStateReachableViaWWAN = 1,
    NetWorkingStateReachableViaWiFi = 2,
    
}NetWorkingState;

/** 用户状态 */
typedef enum : NSUInteger {
    
    ASDUserStateGuest = 0,          // 游客
    ASDUserStateverified = 1,       // 已登录
}ASDUserState;

/** 首页其他功能点击类型 */
typedef enum : NSUInteger {
    
    ASDHomeOtherFunctionTypeStockSchool,             // 股民学校
    ASDHomeOtherFunctionTypeEquityPledgeInfo,        // 股权质押
    
}ASDHomeOtherFunctionType;

/* K线主图样式 */
typedef enum : NSUInteger {
    KLineMainViewTypeKLine = 1,     // K线图(蜡烛图)
    KLineMainViewTypeKLineWithMA,   // K线图包含MA
    KLineMainViewTypeTimeLine,      // 分时图
    KLineMainViewTypeTimeLineWithMA,// 分时图包含MA
    KLineMainViewTypeKLineWithBOLL, // K线图包含BOLL指数
} KLineMainViewType;

/* K线附图样式 */
typedef enum : NSUInteger {
    KLineAssistantViewTypeVol = 1,      // 成交量
    KLineAssistantViewTypeVolWithMA,    // 成交量包含MA
    KLineAssistantViewTypeKDJ,          // KDJ
    KLineAssistantViewTypeMACD,         // MACD
    KLineAssistantViewTypeRSI,          // RSI
} KLineAssistantViewType;


/** 挂单列表的展示数据类型 */
typedef enum : NSUInteger {
    
    OrderBookDisPlayDataTypeAmount,             // 金额 / 币量
    OrderBookDisPlayDataTypeCount,              // 数量
    
}OrderBookDisPlayDataType;

/* 排行榜列表类型 */
typedef enum : NSUInteger {
    ASDSimulateRankTypeTotal,       // 总盈利榜
    ASDSimulateRankTypeShortLine,   // 短线榜
    ASDSimulateRankTypeSteady,      // 稳健榜
    ASDSimulateRankTypeSucRate,     // 成功率榜
    ASDSimulateRankTypeLately,      // 近期牛人
    ASDSimulateRankTypeUp           // 涨停榜
} ASDSimulateRankType;
#endif 
