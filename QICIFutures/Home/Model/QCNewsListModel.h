//
//  QCNewsListModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCNewsListModel : NSObject
@property (strong, nonatomic) NSString *descrip;
@property (strong, nonatomic) NSString *funType;
@property (strong, nonatomic) NSString *imgsrc1;
@property (strong, nonatomic) NSString *imgsrc2;
@property (strong, nonatomic) NSString *imgsrc3;
@property (strong, nonatomic) NSString *layout;
@property (strong, nonatomic) NSString *newsId;
@property (strong, nonatomic) NSString *newsType;
@property (strong, nonatomic) NSString *realPublishTime;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *topic;


+ (instancetype)createHomeNewsModel;
@end

NS_ASSUME_NONNULL_END
