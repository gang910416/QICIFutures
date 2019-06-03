//
//  ShareAppModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <Foundation/Foundation.h>
typedef void(^SucceessBlock)(BOOL success);
NS_ASSUME_NONNULL_BEGIN

@interface ShareAppModel : NSObject
+ (void)mq_share:(NSArray *)items target:(id)target success:(SucceessBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
