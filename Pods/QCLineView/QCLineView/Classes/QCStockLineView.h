//
//  StockLineView.h
//  THSGP
//
//  Created by Bingo on 2019/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCStockLineView : UIView



//该view的大小就是k线图的大小
-(instancetype)instanceViewWithSize:(CGSize)size;

// 数组中包括k线图的锚点
/**
 *   数组中包括k线图的锚点
 *
 *  @param data 锚点数据
 *
 *  high      最高价
 *  open      开盘价
 *  low       最低价
 *  close     收盘价
 *  date      时间
 *  ma5       5天平均值
 *  ma10      10天平均值
 *  ma20      20天平均值
 *  volume    成交量
 */

-(void)reloadData:(NSArray *)data;




@end

NS_ASSUME_NONNULL_END

