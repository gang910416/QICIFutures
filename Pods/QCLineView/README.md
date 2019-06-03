# QCLineView

[![CI Status](https://img.shields.io/travis/liyongfei12138/QCLineView.svg?style=flat)](https://travis-ci.org/liyongfei12138/QCLineView)
[![Version](https://img.shields.io/cocoapods/v/QCLineView.svg?style=flat)](https://cocoapods.org/pods/QCLineView)
[![License](https://img.shields.io/cocoapods/l/QCLineView.svg?style=flat)](https://cocoapods.org/pods/QCLineView)
[![Platform](https://img.shields.io/cocoapods/p/QCLineView.svg?style=flat)](https://cocoapods.org/pods/QCLineView)


## Requirements
```需要导入头文件QCStockLineView.h，这个就是k线图的view。
 使用 -(instancetype)instanceViewWithSize:(CGSize)size 方法初始化这里传入的size就是k线图的大小，建议高度设置为300
 使用 -(void)reloadData:(NSArray *)data 方法传入数据,建议传入30天的数据
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
```


## Installation

it, simply add the following line to your Podfile:

```ruby
pod 'QCLineView'
```

## Author

liyongfei12138,miap972712779@qq.com

