//
//  NSObject+ASD.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/26.
//  Copyright © 2019 ASD. All rights reserved.
//

#import "NSObject+rubbish.h"

@implementation NSObject (rubbish)



- (NSNumber *)viewDid_adf:(NSNumber *)arg num:(NSNumber *)num arg:(NSString *)arg2  {
    
    NSString *astring = [NSString stringWithFormat:@"%s--%@",__FILE__,arg];
    
    NSString *string = arg2;
    
    NSNumber *numObj = num;
    
    if (arg && string) {
        numObj = @(arc4random() % 200 + [arg integerValue]);
    }
    
    if (string) {
        [astring stringByAppendingString:string];
    }
    return numObj;
}

- (NSInteger )cell_wrfg:(NSArray *)arg string:(NSString *)string num:(NSNumber *)num {
    
    NSString *tempString = [NSString stringWithFormat:@"%s--%@",__FILE__,string];
    
    NSArray *ret = @[@"1",@"2",@"3"];
    
    NSNumber *tempNum = num;
    
    if (tempNum && tempString) {
        ret = [NSArray arrayWithArray:arg];
    }
    
    if (arg) {
        ret = @[];
    }
    
    return ret.count;
}

- (NSString *)single_dfsbfd:(NSString *)arg num:(NSInteger)baseNum arr:(NSArray <NSString *>*)arr {
    
    NSString *string = [NSString stringWithFormat:@"%s--%@",__FILE__,arg];
    NSInteger num = baseNum;
    NSString *tempArrStr = [arr componentsJoinedByString:@"-"];
    if (baseNum) {
        string = [string stringByAppendingString:[@(baseNum) stringValue]];
        
        string = [string stringByAppendingString:tempArrStr];
        
        string = [NSString stringWithFormat:@"%@%ld",string,num];
    }
    
    return string;
}

@end
