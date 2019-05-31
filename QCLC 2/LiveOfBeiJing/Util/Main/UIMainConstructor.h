//
//  UMUIConstructor.h
//  youmei
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 um. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIMainConstructor : NSObject

+ (instancetype)sharedUIConstructor;
/**
 *  构建APP的UI层次结构
 *
 *  @return UITabBarController
 */
- (UITabBarController *)constructUI;

@end
