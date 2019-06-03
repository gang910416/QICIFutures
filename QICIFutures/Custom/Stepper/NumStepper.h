//
//  NumStepper.h
//  kkcoin
//
//  Created by walker on 2018/7/23.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//



typedef void(^ValueChangedBlock)(NSString *value);

@interface NumStepper : UIView

/** 输入有变化的回调block */
@property (copy, nonatomic) ValueChangedBlock valueChangeBlock;

/** 内部显示字体 */
@property (strong, nonatomic) UIFont *textFont;

/** 文字 */
@property (strong, nonatomic, readonly) NSString *text;

/** 字体颜色 */
@property (strong, nonatomic) UIColor *textColor;

/** 输入的值 */
@property (readonly, strong, nonatomic) NSString *numValue;

/** placeHolder */
@property (strong, nonatomic) NSAttributedString *attributedPlaceHolder;

/** placeHolder */
@property (strong, nonatomic) NSString *placeHolder;

/**  默认的值 */
@property (assign, nonatomic) double defaultValue;

/**  最大值 */
@property (assign, nonatomic) double maxValue;

/**  最小值 */
@property (assign, nonatomic) double minValue;

/**  小数位数 */
@property (assign, nonatomic) NSInteger decimal;

/**  增加，减小的量度值 */
@property (assign, nonatomic) double scaleValue;

/**  是否强制使用数字键盘 , 默认强制使用数字键盘 */
@property (assign, nonatomic) BOOL isForceNumKeyBoard;

/**  是否允许粘贴 */
@property (assign, nonatomic) BOOL isCanPaste;

/**  是否可以编辑 */
@property (assign, nonatomic) BOOL isCanEdit;

/**
 初始化
 
 @param frame 尺寸
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 初始化

 @param frame 尺寸
 @param isHide 是否隐藏加减号
 */
- (instancetype)initWithFrame:(CGRect)frame hideFineTuning:(BOOL)isHide;

/**
 更新显示的文字

 @param text text
 */
- (void)updateText:(NSString *)text;
@end
