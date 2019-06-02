//
//  TheMarktNewsModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktNewsModel : NSObject

//@property (nonatomic,copy) NSString *newsId;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *publishDate;

@property (nonatomic,copy) NSString *descriptionInfo;

@property (nonatomic,copy) NSString *cover;

@property (nonatomic,copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
