//
//  ASDResponseSerializer.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "QICIResponseSerializer.h"

@implementation QICIResponseSerializer
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    return self;
}
@end
