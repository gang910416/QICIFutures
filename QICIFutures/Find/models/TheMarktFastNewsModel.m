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
        
    }else if([key isEqualToString:@"Title"]){
        
        NSScanner *theScanner;
        
        NSString *text = nil;
        NSString *str = (NSString *)value;
        
        theScanner = [NSScanner scannerWithString:str];
        
        while ([theScanner isAtEnd] == NO) {
            
            // find start of tag
            [theScanner scanUpToString:@"<" intoString:NULL] ;
            
            // find end of tag
            [theScanner scanUpToString:@">" intoString:&text] ;
            
            // replace the found tag with a space
            //(you can filter multi-spaces out later if you wish)
            str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        }
        [super setValue:str forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}



@end
