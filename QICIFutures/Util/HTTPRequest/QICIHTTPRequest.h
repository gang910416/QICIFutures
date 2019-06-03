

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HttpSuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^HttpFaileBlock)(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error);

@interface QICIHTTPRequest : NSObject

@property (nonatomic,strong)AFHTTPSessionManager *manager;

+(instancetype)sharedInstance;

-(void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(NSDictionary * _Nullable)parameters success:(HttpSuccessBlock)successBlock faile:(HttpFaileBlock)faileBlock;

-(void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(NSDictionary * _Nullable)parameters success:(HttpSuccessBlock)successBlock faile:(HttpFaileBlock)faileBlock;
@end
NS_ASSUME_NONNULL_END
