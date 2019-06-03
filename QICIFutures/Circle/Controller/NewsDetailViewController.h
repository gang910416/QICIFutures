#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailViewController : BaseHiddenBarViewController
@property (nonatomic,strong) NSString *newsid;
@property (nonatomic,strong) NSArray *dataArr;
@end

NS_ASSUME_NONNULL_END
