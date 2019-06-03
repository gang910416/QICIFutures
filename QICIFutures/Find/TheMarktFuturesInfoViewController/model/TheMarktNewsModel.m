//
//  TheMarktNewsModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/2.
//

#import "TheMarktNewsModel.h"

@implementation TheMarktNewsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"descriptionInfo":@"description"};
}

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"cover"]) {
        NSString *str = [value stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        [super setValue:str forKey:key];
    }else if([key isEqualToString:@"url"]){
        NSString *str = value;
        if (![str hasPrefix:@"http"]) {
            NSString *temp = [NSString stringWithFormat:@"http:%@",str];
            [super setValue:temp forKey:key];
        }else{
            [super setValue:value forKey:key];
        }
    }else{
        [super setValue:value forKey:key];
    }
    
}

@end
