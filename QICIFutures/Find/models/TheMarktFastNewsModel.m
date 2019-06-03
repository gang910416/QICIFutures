//
//  TheMarktFastNewsModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktFastNewsModel.h"

@implementation TheMarktFastNewsModel

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"UpdateTime"]) {
        
        NSString *time = [TheMarktTools getDateStringWithTimeStr:value];
        [super setValue:time forKey:key];
        
    }else{
        [super setValue:value forKey:key];
    }
}



@end
