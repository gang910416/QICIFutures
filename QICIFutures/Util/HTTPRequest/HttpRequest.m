
#import "HttpRequest.h"

@implementation HttpRequest

+(instancetype) sharedInstance {
    static HttpRequest *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[self alloc]init];
    });
    return networking;
}
-(instancetype)init {
    if (self = [super init]) {
      _manager = [[AFHTTPSessionManager alloc]init];
      _manager.requestSerializer.timeoutInterval = 10.f;
      _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    return self;
}



#define STRINGNOTBASEURL(string) string.length==0?kBaseUrl:string

-(void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock{



    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
 
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
      
            successBlock(responseObject);

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (faileBlock) {
            faileBlock(error);
        }
    }];

}

-(void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock  {
    

    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
    
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {

            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (faileBlock) {
            faileBlock(error);
        }
    }];
}




@end
