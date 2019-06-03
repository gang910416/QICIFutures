//
//  KeyBoardManager.m
//  kkcoin
//
//  Created by walker on 2018/6/9.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "KeyBoardManager.h"

@interface KeyBoardManager ()
/**
 代理集合类
 */
@property (strong, nonatomic) NSPointerArray *delegateContainer;

@end

@implementation KeyBoardManager

#pragma mark - 单例相关 -----begin---
/*
 创建静态对象 防止外部访问
 */
static KeyBoardManager *_manager;
/**
 重写初始化方法
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [super allocWithZone:zone];
            // 添加键盘改变的监听
            [_manager p_addKeyBoardChangedNotification];
            [_manager single_dfsbfd:@"daslkl" num:3 arr:@[@"a",@"s",@"d"]];
        }
    });
    return _manager;
}

/**
 快速创建单例对象的类方法
 
 @return 单利对象
 */
+ (instancetype)shareManager
{
    return [[self alloc]init];
}

/**
 重写copyWithZone
 */
- (id)copyWithZone:(NSZone *)zone
{
    return _manager;
}

/**
 重写mutableCopyWithZone
 */
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _manager;
}

#pragma mark - 单例相关 ----- end ---

#pragma mark - 代理相关 ----- begin ---

/**
 添加代理
 
 @param delegate 遵循<KeyBoardChangeProtocol>协议的代理
 支持多代理模式，但是要记得移除，否则会造成多次调用
 */
- (void)addDelegate:(id<KeyBoardChangeProtocol>)delegate {
    if(delegate) {
        for (id tempDelegate in self.delegateContainer) {
            if ([tempDelegate isEqual:delegate]) {
                // 已经有了这个代理直接return
                return;
            }
        }
        // 将代理添加到弱引用容器中
        [self.delegateContainer addPointer:(__bridge void * _Nullable)(delegate)];
    }
    
    // 自动检测并移除失效的代理
    [self.delegateContainer compact];
}

/**
 移除代理
 
 @param delegate 遵循<KeyBoardChangeProtocol>协议的代理
 */
- (void)removeDelegate:(id<KeyBoardChangeProtocol>)delegate {
    
    if (delegate) {
        for (int a = 0 ; a < self.delegateContainer.count ; a ++) {
            
            id tempDelegate = [self.delegateContainer pointerAtIndex:a];
            
            if (tempDelegate && [tempDelegate isEqual:delegate]) {
                [self.delegateContainer removePointerAtIndex:a];
                break;
            }
        }
    }
    
    // 自动检测并移除失效的代理
    [self.delegateContainer compact];
}


/**
 代理弱引用容器的懒加载
 */
- (NSPointerArray *)delegateContainer {
    
    if(!_delegateContainer) {
        _delegateContainer = [NSPointerArray weakObjectsPointerArray];
    }
    return _delegateContainer;
}
#pragma mark - 代理相关 ----- end ---

#pragma mark - 私有方法 ---
/* 添加观察者 */
- (void)p_addKeyBoardChangedNotification {
    // 键盘将要出现的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 键盘已经出现的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    // 键盘将要消失的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘已经消失的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    // 键盘将要改变Frame的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 键盘已经改变Frame的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_keyBoardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

// ---------- 各种监听方法 -------
- (void)p_keyBoardWillShow:(NSNotification *)keyBoardNotification {
    
    [self p_changeType:KeyBoardChangedTypeWillShow userInfo:keyBoardNotification.userInfo];
}

- (void)p_keyBoardDidShow:(NSNotification *)keyBoardNotification {
    
    [self p_changeType:KeyBoardChangedTypeDidShow userInfo:keyBoardNotification.userInfo];
}
- (void)p_keyBoardWillHide:(NSNotification *)keyBoardNotification {
    
    [self p_changeType:KeyBoardChangedTypeWillHide userInfo:keyBoardNotification.userInfo];
}

- (void)p_keyBoardDidHide:(NSNotification *)keyBoardNotification {
    
    [self p_changeType:KeyBoardChangedTypeDidHide userInfo:keyBoardNotification.userInfo];
}

- (void)p_keyBoardWillChangeFrame:(NSNotification *)keyBoardNotification {
    
    [self p_changeType:KeyBoardChangedTypeWillChangeFrame userInfo:keyBoardNotification.userInfo];
}

- (void)p_keyBoardDidChangeFrame:(NSNotification *)keyBoardNotification {
    
    [self p_changeType:KeyBoardChangedTypeDidChangedFrame userInfo:keyBoardNotification.userInfo];
}


/**
 统一处理键盘状态改变的通知

 @param changeType 通知类型
 @param info 通知信息
 */
- (void)p_changeType:(KeyBoardChangedType)changeType userInfo:(NSDictionary *)info {
    
    if (!changeType) {
        return;
    }
    
    // frame
    CGRect beginFrame = CGRectZero;
    CGRect endFrame = CGRectZero;
    if (info) {
        beginFrame = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        endFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    }
    
    // 发送代理消息
    if (self.delegateContainer.count >= 1) {
        [self.delegateContainer compact];
        
        for (id<KeyBoardChangeProtocol>delegate in self.delegateContainer) {
            if (delegate && [delegate respondsToSelector:@selector(keyBoardStateChangedWithType:beginFrame:endFrame:userInfo:)]) {
                [delegate keyBoardStateChangedWithType:changeType beginFrame:beginFrame endFrame:endFrame userInfo:info];
            }
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
