

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id responsData);
typedef void(^FaileBlock)(NSError *error);
typedef void(^MySuccessBlock)(id object , NSURLResponse *response);

@interface HttpRequest : NSObject
@property (nonatomic,strong)AFHTTPSessionManager *manager;
+(instancetype) sharedInstance;
-(void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock;
-(void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock ;
- (void)GETRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(MySuccessBlock)success FailBlock:(FaileBlock)fail;
@end
