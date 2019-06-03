//
//  UserModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
+ (UserModel *) getInstance;

//获取用户是否登录
- (BOOL) getUserIsLogin;
// 用户退出登录
- (void)userLogOut;

// 用户登录
- (void)userLogIn;

@end

NS_ASSUME_NONNULL_END
