

#import "QICIFavManager.h"
#import "QICIMarkeModel.h"
@interface QICIFavManager ()

@property (readwrite, strong, nonatomic) NSMutableArray *favArray;

@end

@implementation QICIFavManager
#pragma mark - 单例相关 -----begin---
/*
 创建静态对象 防止外部访问
 */
static QICIFavManager *_manager;

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
            
            [_manager favArray];
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

#pragma mark - 公共方法 --

/**
 获得收藏列表
 
 @param callBack 回调
 */
- (void)getFavArrayWithCallback:(void(^)(NSArray *favList))callBack {

    if (self.favArray) {
        !callBack ? : callBack(self.favArray);
    }
}

/**
 查找是否收藏
 
 @param symbol 股票唯一标识符
 @return 收藏为YES
 */
- (BOOL)isFavWithSymbol:(NSString *)symbol {
    
    BOOL isExist = NO;
    for (QICIMarkeModel *tempModel in self.favArray) {
        
        if ([tempModel.prod_code isEqualToString:symbol]) {
            isExist = YES;
        }
    }
    
    return isExist;
}

/**
 添加自选
 
 @param listModel 自选模型
 @param callBack 回调
 */
- (void)addFavWithMarketListModel:(QICIMarkeModel *)listModel callBack:(FavCallBackBlock)callBack {
    
    if (!listModel) {
        !callBack ? : callBack(NO, listModel);
        return;
    }
    
    if (![self isFavWithSymbol:listModel.prod_code]) {
        
        [self.favArray addObject:listModel];
        
        [self p_saveFavArray];
    }
    
    !callBack ? : callBack(YES, listModel);
}


/**
 移除自选
 
 @param listModel 自选模型
 @param callBack 回调
 */
- (void)removeFavWithListModel:(QICIMarkeModel *)listModel callBack:(FavCallBackBlock)callBack {
    
    if (!listModel) {
        !callBack ? : callBack(NO, listModel);
        return;
    }
    
    if ([self isFavWithSymbol:listModel.prod_code]) {
        
        for (QICIMarkeModel *tempModel in [self.favArray copy]) {
            
            if ([tempModel.prod_code isEqualToString:listModel.prod_code]) {
                [self.favArray removeObject:tempModel];
                break;
            }
        }
        
        [self p_saveFavArray];
    }
    
    !callBack ? : callBack(YES, listModel);
}

#pragma mark - 私有方法 --

//- (NSArray *)p_getFavInfoFromLocal {
//
////    NSArray *favDict = [NSKeyedUnarchiver unarchiveObjectWithFile:ASD_ArchiverPath_Fav];
//
//    return favDict ? : @[];
//}

- (void)p_saveFavArray {
    
    if (self.favArray) {
//        [NSKeyedArchiver archiveRootObject:self.favArray toFile:ASD_ArchiverPath_Fav];
    }
}

#pragma mark - lazy load ---

- (NSMutableArray *)favArray {
    
    if (!_favArray) {
        
//        _favArray = [[self p_getFavInfoFromLocal] mutableCopy];
    }
    return _favArray;
}

@end
