#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^SuccessBlock)(id responsData);
typedef void(^MySuccessBlock)(id object , NSURLResponse *response);
typedef void(^FaileBlock)(NSError *error);
#define sHttpRequest [YNWHttpRequest sharedInstance]
@interface YNWHttpRequest : NSObject
@property (nonatomic,strong)AFHTTPSessionManager *manager;
+(instancetype) sharedInstance;
-(void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock;
-(void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock ;
- (void)GETRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(MySuccessBlock)success FailBlock:(FaileBlock)fail;
@end
