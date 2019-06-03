

#import <Foundation/Foundation.h>
@class QICIMarkeModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^FavCallBackBlock)(BOOL suc, QICIMarkeModel *listModel);

@interface QICIFavManager : NSObject

@property (readonly, strong, nonatomic) NSMutableArray *favArray;

/* 初始化单例类 */
+ (instancetype)manager;

/**
 获得收藏列表

 @param callBack 回调
 */
- (void)getFavArrayWithCallback:(void(^)(NSArray *favList))callBack;

/**
 查找是否收藏

 @param symbol 股票唯一标识符
 @return 收藏为YES
 */
- (BOOL)isFavWithSymbol:(NSString *)symbol;

/**
 添加自选

 @param listModel 自选模型
 @param callBack 回调
 */
- (void)addFavWithMarketListModel:(QICIMarkeModel *)listModel callBack:(FavCallBackBlock)callBack;


/**
 移除自选

 @param listModel 自选模型
 @param callBack 回调
 */
- (void)removeFavWithListModel:(QICIMarkeModel *)listModel callBack:(FavCallBackBlock)callBack;
@end

NS_ASSUME_NONNULL_END
