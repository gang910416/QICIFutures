//
//  TheMarktFuturesInfoViewController.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktFuturesInfoViewController : TheMarktBaseViewController

@property (nonatomic,copy) NSString *infoKey;

@property (nonatomic,copy) NSString *infoType;

@property (nonatomic,copy) void(^isRefreshListView)(BOOL isDo);

@end

NS_ASSUME_NONNULL_END
