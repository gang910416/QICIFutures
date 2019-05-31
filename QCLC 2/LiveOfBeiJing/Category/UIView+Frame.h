//
//  UIView+Frame.h
// frame 分类

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// 在分类中 @property 只会生成get, set方法,并不会生成下划线的成员属性

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;




@end
