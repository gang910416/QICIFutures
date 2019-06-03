#import "YNWHttpRequest.h"
@implementation YNWHttpRequest
+(instancetype) sharedInstance {
    static YNWHttpRequest *networking = nil;
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
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,path];
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
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,path];
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

- (void)GETRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(MySuccessBlock)success FailBlock:(FaileBlock)fail
{
    NSMutableString *strM = [[NSMutableString alloc] init];
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *paramaterKey = key;
        NSString *paramaterValue = obj;
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
    urlString = [urlString substringToIndex:urlString.length - 1];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            if (!obj) {
                obj = data;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    NSLog(@"%@",obj);
                    success(obj,response);
                }
            });
        }else 
        {
            if (fail) {
                fail(error);
            }
        }
    }] resume];
}
@end
