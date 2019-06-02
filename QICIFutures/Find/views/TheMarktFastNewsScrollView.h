//
//  TheMarktFastNewsScrollView.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <UIKit/UIKit.h>
#import "TheMarktRequestViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktFastNewsScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UILabel *infoLabel;

@property (nonatomic,strong) TheMarktRequestViewModel *viewModel;

@property (nonatomic,strong) NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
