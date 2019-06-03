//
//  ASDNewsListViewController.h
// ASDFutureProject
//
//  Created by Mac on 2019/4/29.
//  Copyright © 2019 ASD. All rights reserved.
//

#import "QICIHideBarViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCNewsListViewController : QICIHideBarViewController

/**
 是否需要返回按钮

 @param needBackBtn 是否需要返回按钮
 */
- (instancetype)initWithNeedBackBtn:(BOOL)needBackBtn;
@end

NS_ASSUME_NONNULL_END
