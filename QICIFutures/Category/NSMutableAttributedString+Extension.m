//
//  NSMutableAttributedString+Extension.m
//  LiveOfBeiJing
//
//  Created by liuyongfei on 2018/11/28.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

+(NSMutableAttributedString *)stringToAgreementAttrSting:(NSString *)str
{
    NSDictionary *attributeDict = @{
                                    NSFontAttributeName:[UIFont fontWithName:fFont size:12.f],
                                    NSForegroundColorAttributeName:RGBColor(200, 200, 200)
                                    };
    
        if ([str containsString:@"用户服务协议"]) {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attributeDict];
            NSRange range = [[attrStr string] rangeOfString:@"用户服务协议"];
            [attrStr addAttribute:NSForegroundColorAttributeName value:RGBColor(102, 102, 102) range:range];
    
            return attrStr;
        }else{
            return [[NSMutableAttributedString alloc] initWithString:str attributes:attributeDict];;
        }
}
@end
