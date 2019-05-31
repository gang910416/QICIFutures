
#import <Foundation/Foundation.h>

@interface FileCacheManager : NSObject
/**
 *  计算文件夹的尺寸
 *
 *  @param directoriesPath 文件路径
 *  @param completeBlock   计算完后回调block
 */
+ (void)getCacheSizeOfDirectoriesPath:(NSString *)directoriesPath completeBlock:(void(^)(NSInteger))completeBlock;

/**
 *  清空路径下的缓存
 *
 *  @param direstoriesPath 文件路径
 */
+ (void)removeDirectoriesPath:(NSString *)directoriesPath;
@end
