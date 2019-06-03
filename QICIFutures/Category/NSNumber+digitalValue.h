//
//  NSNumber+digitalValue.h
//  kkcoin
//
//  Created by 幽雅的暴君 on 2018/12/20.
//  Copyright © 2018 KKCOIN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (digitalValue)
/* 将字符串转换为小数对象 */
- (NSDecimalNumber *)gl_digitalValue;
@end

NS_ASSUME_NONNULL_END
