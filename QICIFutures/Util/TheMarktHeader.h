//
//  TheMarktHeader.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

/*
 行情页面所需全局宏定义
 */

#ifndef TheMarktHeader_h
#define TheMarktHeader_h

#import "SaveAndUseFuturesDataModel.h"
#import "TheMarktTools.h"
#import <MJExtension.h>

#import "TheMarktBaseViewController.h"
#import "TheMarktBseNavigationViewController.h"

#define MarktGlobalColor RGBColor(156, 210, 254)

#define tokenKey @"3f39051e89e1cea0a84da126601763d8"

#define weakSelf(weakSelf) __weak __typeof(&*self) weakSelf = self

#define TheMarktUserDefault [NSUserDefaults standardUserDefaults]

//所有国内期货
#define AllDomesticFutures @"AllDomesticFutures"
//所有国内菜油期货
#define AllDomesticVegetableOilFutures @"AllDomesticVegetableOilFutures"
//所有国外商品期货
#define AllForeignGoodsFutures @"AllForeignGoodsFutures"
//所有国外股指期货
#define AllForeignStockIndexFutures @"AllForeignStockIndexFutures"
//所有国外外汇期货
#define AllForeignCurrencyFutures @"AllForeignCurrencyFutures"
//我关注的期货
#define AllMyLikeFutures @"AllMyLikeFutures"
//目前登录的账号
#define WhoIsLoginNow @"WhoIsLoginNow"

#define imageWithName(n) [UIImage imageNamed:n]

#define SVPShowInfo(time,info,block) [SVProgressHUD show];\
[SVProgressHUD dismissWithDelay:time completion:^{\
[SVProgressHUD showSuccessWithStatus:info];\
[SVProgressHUD dismissWithDelay:time];\
block();\
}];\

#endif /* TheMarktHeader_h */
