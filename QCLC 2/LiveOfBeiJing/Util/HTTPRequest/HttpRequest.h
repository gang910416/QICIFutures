

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id responsData);
typedef void(^FaileBlock)(NSError *error);

#define sHttpRequest [HttpRequest sharedInstance]
@interface HttpRequest : NSObject
@property (nonatomic,strong)AFHTTPSessionManager *manager;
+(instancetype) sharedInstance;
-(void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock;
-(void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock ;
@end
