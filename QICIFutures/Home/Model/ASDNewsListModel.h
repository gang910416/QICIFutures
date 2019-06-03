//
//  ASDNewsListModel.h
// ASDFutureProject
//
//  Created by Mac on 2019/5/15.
//  Copyright © 2019 ASD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASDNewsListModel : NSObject

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

+ (instancetype)createDefaultModel;

@end

NS_ASSUME_NONNULL_END
