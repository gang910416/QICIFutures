//
//  SimpleKLineVolView.h
//  GLKLineKit
//
//  Created by walker on 2018/5/25.
//  Copyright © 2018年 walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "ASDKLineView.h"

@interface SimpleKLineVolView : UIView

/**
 数据中心
 */
@property (strong, nonatomic) DataCenter *dataCenter;

/**
 K线主图
 */
@property (strong, nonatomic) ASDKLineView *kLineMainView;

/**
 K线副图(VOL)
 */
@property (strong, nonatomic) ASDKLineView *volView;

/**
 切换主图样式
 */
- (void)switchKLineMainViewToType:(KLineMainViewType)type;

/**
 重新绘制
 缩放比例还是按照之前显示的比例
 @param drawType 绘制时采用的类型
 */
- (void)reDrawWithType:(ReDrawType)drawType;

@end
