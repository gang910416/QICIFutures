//
//  EEEHomeNewsModel.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "ASDNewsDetailModel.h"

@implementation ASDNewsDetailModel

/**
 生成一个默认的假的新闻模型
 */
+ (instancetype)createModelWithReq:(NSDictionary *)reqDict {
    
    ASDNewsDetailModel *model = [[ASDNewsDetailModel alloc] init];
    
    if(reqDict && [reqDict isKindOfClass:[NSDictionary class]] && reqDict.count > 0) {
     
        model.digest = [reqDict objectForKey:@"digest"];
        model.newsId = [reqDict objectForKey:@"newsId"];
        model.realPublishTime = [reqDict objectForKey:@"realPublishTime"];
        model.source = [reqDict objectForKey:@"source"];
        model.time = [reqDict objectForKey:@"time"];
        model.title = [reqDict objectForKey:@"title"];
        model.shareUrl = [reqDict objectForKey:@"shareUrl"];
        model.newsType = [reqDict objectForKey:@"newsType"];
        model.body = [[reqDict objectForKey:@"news"] objectForKey:@"body"];

    }
    return model;
}

- (NSString *)body {
    if (!isStrEmpty(_body)) {
        
        if (![_body containsString:@"color: blue; font-size: 30"]) {

            _body = [self p_artWithContent:_body];
        }
    }
    return _body;
}

- (NSString *)p_artWithContent:(NSString *)content {
    
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type='text/css'>\n"
                       "p {font-size: 30; padding-left: 30; padding-right: 30;    padding-top: 30; }\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",content];
    return htmls;
}


@end



