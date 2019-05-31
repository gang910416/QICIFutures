

#import "FileCacheManager.h"

@implementation FileCacheManager
//计算大小
// 业务类:专门处理某个业务,网络请求类,处理文件缓存
// 注意:attributesOfItemAtPath只对文件有效,对文件夹无效
// 如何获取文件尺寸,遍历文件夹下所有文件,全部加起来.
// 获取文件夹尺寸
// 只要是异步方法,就不需要设置返回值.没有意义
//+ (void)getCacheSizeOfDirectoresPath:(NSString *)directoriesPath completeBlock:(void(^)(NSInteger))completeBlock{
//    //开启异步方法
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //1.创建文件管理者
//        NSFileManager *manager = [NSFileManager defaultManager];
//        
//        //判断是否是文件夹
//        BOOL isDirectory;
//        BOOL isExist = [manager fileExistsAtPath:directoriesPath isDirectory:&isDirectory];
//        if (!isExist || ! isDirectory) {
//            NSException *except = [NSException exceptionWithName:@"乱传" reason:@"必须传入文件夹路径" userInfo:nil];
//            [except raise];
//        }
//        //2.获取文件夹的所有文件路径
//        NSArray *subPaths = [manager subpathsAtPath:directoriesPath];
//        
//        //遍历文件夹下所有文件
//        NSInteger totalSize = 0;
//        for (NSString *subPath in subPaths) {
//            //拼接当下文件全路径
//            NSString *filePath = [directoriesPath stringByAppendingPathComponent:subPath];
//            BOOL isDirectory;
//            BOOL isExist = [manager fileExistsAtPath:subPath isDirectory:&isDirectory];
//            //不是隐藏文件,或者不是文件夹   就计算
//             if ([filePath containsString:@"DS"] || !isExist ||isDirectory) continue;
//            
//            // 3.获取文件属性
//            NSDictionary *attr = [manager attributesOfItemAtPath:filePath error:nil];
//            
//            // 4.获取文件尺寸
//            NSInteger fileSize = [attr[NSFileSize] integerValue];
//            
//            totalSize += fileSize;
//        }
//        // 在主线程回调
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            // 计算完,搞个Block回调
//            if (completeBlock) {
//                completeBlock(totalSize);
//            }
//        });
//    });
//}
+ (void)getCacheSizeOfDirectoriesPath:(NSString *)directoriesPath completeBlock:(void(^)(NSInteger))completeBlock
{
    // 开启异步方法
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // 判断下是否是文件夹
        BOOL isDirectory;
        BOOL isExists = [mgr fileExistsAtPath:directoriesPath isDirectory:&isDirectory];
        
        if (!isExists || !isDirectory) {
            // 抛异常
            NSException *excp = [NSException exceptionWithName:@"乱传" reason:@"必须传入文件夹路径" userInfo:nil];
            [excp raise];
        }
        
        // 2.获取所有文件夹所有文件的路径
        // 指定一个文件夹路径,就获取这个文件夹路径里所有的子路径
        NSArray *subpaths = [mgr subpathsAtPath:directoriesPath];
        
        NSInteger totalSize = 0;
        
        // 遍历文件夹下的所有文件
        for (NSString *subpath in subpaths) {
            // 拼接文件全路径
            NSString *filePath = [directoriesPath stringByAppendingPathComponent:subpath];
            // 判断下是否是文件夹
            BOOL isDirectory;
            BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            if ([filePath containsString:@"DS"] || !isExists || isDirectory) continue;
            
            // 不是隐藏文件,或者不是文件夹
            
            // 3.获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            // 4.获取文件尺寸
            NSInteger fileSize = [attr[NSFileSize] integerValue];
            
            totalSize += fileSize;
        }
        
        // 在主线程回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            // 计算完,搞个Block回调
            if (completeBlock) {
                completeBlock(totalSize);
            }
        });
    });
    
}


#pragma mark - remove
+ (void)removeDirectoriesPath:(NSString *)directoriesPath
{
    // 清空缓存,删除文件
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断下是否是文件夹
    BOOL isDirectory;
    BOOL isExists = [mgr fileExistsAtPath:directoriesPath isDirectory:&isDirectory];
    
    if (!isExists || !isDirectory) {
        // 抛异常
        NSException *excp = [NSException exceptionWithName:@"乱传" reason:@"必须传入文件夹路径" userInfo:nil];
        [excp raise];
    }
    
    // 获取文件夹里所有文件
    NSArray *subpaths = [mgr subpathsAtPath:directoriesPath];
    
    // 遍历所有的文件
    for (NSString *subpath in subpaths) {
        // 拼接文件全路径
        NSString *filePath = [directoriesPath stringByAppendingPathComponent:subpath];
        
        [mgr removeItemAtPath:filePath error:nil];
    }
}
@end
