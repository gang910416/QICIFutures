//
//  ASDRequestSerializer.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "QICIRequestSerializer.h"

@implementation QICIRequestSerializer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // 设置缓存策略
    self.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    self.timeoutInterval = 10.0f;
    
    return self;
}

@end
