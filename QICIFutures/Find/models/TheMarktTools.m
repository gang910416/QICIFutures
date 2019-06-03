//
//  TheMarktTools.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktTools.h"
#import "Reachability.h"

@implementation TheMarktTools

+(CGFloat)widthWithString:(NSString *)text withheight:(CGFloat)height withFontSize:(CGFloat)fontSize{
    
    CGSize textSize = CGSizeMake(0, height);
    
    NSDictionary *font = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    
    CGRect rect = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:font context:nil];
    
    return rect.size.width;
}

+(NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

+(UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);//图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    
    return image;
    
}

+(BOOL)internetStatus{
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    //    NSString *net = @"WIFI";
    BOOL isCon = YES;
    switch (internetStatus) {
        case ReachableViaWiFi:
            //            net = @"WIFI";
            isCon = YES;
            break;
            
        case ReachableViaWWAN:
            //            net = @"蜂窝数据";
            isCon = YES;
            //net = [self getNetType ];   //判断具体类型
            break;
            
        case NotReachable:
            //            net = @"当前无网路连接";
            isCon = NO;
            
        default:
            break;
    }
    
    return isCon;
}

@end
