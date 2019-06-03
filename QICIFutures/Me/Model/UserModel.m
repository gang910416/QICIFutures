//
//  UserModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "UserModel.h"

@implementation UserModel
static UserModel *instance = nil;

#define kSAVE_USERINFOR @"save_userinfor"

+(UserModel *) getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      instance = [[self alloc]init];
                  });
    return instance;
}

// 用户退出登录
- (void)userLogOut{
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kSAVE_USERINFOR];
    
}
- (BOOL) getUserIsLogin{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kSAVE_USERINFOR] boolValue];
}
// 用户登录
- (void)userLogIn{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSAVE_USERINFOR];
}

@end
