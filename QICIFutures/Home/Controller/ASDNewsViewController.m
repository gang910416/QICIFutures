
//
//  ASDNewsViewController.m
// ASDFutureProject
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "ASDNewsViewController.h"
#import "ASDNewsDetailModel.h"
#import "QCNewsLogic.h"
@interface ASDNewsViewController ()

/** newsId */
@property (strong, nonatomic) NSString *newsId;

@property (strong, nonatomic) ASDNewsDetailModel *newsDetailModel;

@end

@implementation ASDNewsViewController

- (instancetype)initWithNewsId:(NSString *)newsId {
    
    if (self = [super init]) {
        
        if (!isStrEmpty(newsId)) {
            self.newsId = newsId;
            
            [self p_requestData];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewDid_adf:@(arc4random() % 100)  num:@(10) arg:@"asd"];
    
    UIImage * img = [UIImage imageNamed:@"icon_ASD_6"];
    
    if(img) {
        self.view.alpha = 1.0f;
    }
    
    if(!isStrEmpty(self.title)) {
        self.navTitleSting = self.title;
    }
}


- (void)p_requestData {
    
    [SVProgressHUD show];
    weakSelf(self);
    [QCNewsLogic getNewsDetailWithNewsId:self.newsId blockSuccess:^(ASDNewsDetailModel * _Nullable detailModel) {
        [SVProgressHUD dismiss];
        [weakSelf p_loadDataWithModel:detailModel];
        
    } faild:^(NSError * _Nullable error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)p_loadDataWithModel:(ASDNewsDetailModel *)detailModel {
    if(detailModel) {
        self.newsDetailModel = detailModel;
        [self updateHtmlString:self.newsDetailModel.body];
    }
}

@end
