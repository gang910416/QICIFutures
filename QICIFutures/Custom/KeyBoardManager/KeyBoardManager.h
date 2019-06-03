//
//  KeyBoardManager.h
//  kkcoin
//
//  Created by walker on 2018/6/9.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import <Foundation/Foundation.h>
// 键盘改变的类型
typedef enum : NSUInteger {
    KeyBoardChangedTypeWillShow = 1,        // 将要显示
    KeyBoardChangedTypeDidShow,             // 已经显示
    KeyBoardChangedTypeWillHide,            // 将要消失
    KeyBoardChangedTypeDidHide,             // 已经消失
    KeyBoardChangedTypeWillChangeFrame,     // 将要改变frame
    KeyBoardChangedTypeDidChangedFrame,     // 已经改变frame
} KeyBoardChangedType;

@protocol KeyBoardChangeProtocol <NSObject>
@optional
/**
 键盘状态改变的回调方法

 @param changeType 改变的类型
 @param beginFrame 键盘开始变化的frame
 @param endFrame    键盘变化后的frame 
 @param info 其他信息
 */
- (void)keyBoardStateChangedWithType:(KeyBoardChangedType)changeType beginFrame:(CGRect)beginFrame endFrame:(CGRect)endFrame userInfo:(NSDictionary *)info;

@end

@interface KeyBoardManager : NSObject

/** 单例初始化 */
+ (instancetype)shareManager;

/**
 添加代理
 
 @param delegate 遵循<KeyBoardChangeProtocol>协议的代理
 支持多代理模式，但是要记得移除，否则会造成多次调用
 */
- (void)addDelegate:(id<KeyBoardChangeProtocol>)delegate;

/**
 移除代理
 
 @param delegate 遵循<KeyBoardChangeProtocol>协议的代理
 */
- (void)removeDelegate:(id<KeyBoardChangeProtocol>)delegate;
@end
