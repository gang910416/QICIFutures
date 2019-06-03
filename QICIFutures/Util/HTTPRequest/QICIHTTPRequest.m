
#import "QICIHTTPRequest.h"
#import "QICIRequestSerializer.h"
#import "QICIResponseSerializer.h"

@implementation QICIHTTPRequest
    
+ (instancetype) sharedInstance {
    static QICIHTTPRequest *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[self alloc]init];
    });
    return networking;
}
    
- (instancetype)init {
    if (self = [super init]) {
        _manager = [[AFHTTPSessionManager alloc]init];
        _manager.requestSerializer = [[QICIRequestSerializer alloc] init];
        _manager.responseSerializer = [[QICIResponseSerializer alloc] init];

    }
    return self;
}

- (void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(HttpSuccessBlock)successBlock faile:(HttpFaileBlock)faileBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
    
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
            successBlock(task ,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (faileBlock) {
            faileBlock(task,error);
        }
    }];
}
    
- (void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(HttpSuccessBlock)successBlock faile:(HttpFaileBlock)faileBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
    
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
            successBlock(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (faileBlock) {
            faileBlock(task, error);
        }
    }];
}
    
@end
