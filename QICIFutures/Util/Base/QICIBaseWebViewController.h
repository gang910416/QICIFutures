


#import "QICIHideBarViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WebVCDidDissMissBlock)(NSString * _Nullable url, NSString * _Nullable htmlString);

@interface QICIBaseWebViewController : QICIHideBarViewController

@property (readonly, strong, nonatomic) NSString *url;

@property (readonly, strong, nonatomic) NSString *htmlString;

@property (readonly, strong, nonatomic) WKWebView *webView;

/* 已经收回 */
@property (copy, nonatomic) WebVCDidDissMissBlock dissMissBlock;

- (instancetype)initWithUrl:(NSString *)url;

- (instancetype)initWithHtmlString:(NSString *)htmlString;

- (void)updateWithUrl:(NSString *)url;

- (void)updateHtmlString:(NSString *)htmlString;

- (void)reloadWebView;
@end

NS_ASSUME_NONNULL_END
