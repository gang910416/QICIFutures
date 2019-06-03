//
//  TheMarktTools.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktTools : NSObject

/**
 计算label宽度

 @param text <#text description#>
 @param height <#height description#>
 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
+(CGFloat)widthWithString:(NSString *)text withheight:(CGFloat)height withFontSize:(CGFloat)fontSize;

/**
 时间戳转时间

 @param str <#str description#>
 @return <#return value description#>
 */
+(NSString *)getDateStringWithTimeStr:(NSString *)str;

/**
 颜色转图片

 @param color <#color description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+(UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

+(BOOL)internetStatus;

@end

NS_ASSUME_NONNULL_END
