//
//  TheMarktAllFuturesViewController.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktBaseViewController.h"

typedef enum : NSUInteger {
    TheMarktAllFuturesViewTypeDomestic,
    TheMarktAllFuturesViewTypeForegin,
} TheMarktAllFuturesViewType;

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktAllFuturesViewController : TheMarktBaseViewController

@property (nonatomic,assign) TheMarktAllFuturesViewType type;

@end

NS_ASSUME_NONNULL_END
