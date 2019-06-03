//
//  TheMarktRequestNewsModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktRequestNewsModel : NSObject

-(void)requestFuturesNewsInfoSuccess:(void(^)(NSArray *dataArray))success failture:(void(^)(NSString *error))failture timeout:(void(^)(void))timeout;

@end

NS_ASSUME_NONNULL_END
