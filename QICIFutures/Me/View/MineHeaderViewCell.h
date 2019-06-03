#import <UIKit/UIKit.h>

//typedef void(^headerImgBlock)(void);

@interface MineHeaderViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *backImage;
@property (nonatomic,strong)UIImageView *header;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *title;
//@property (nonatomic,copy)headerImgBlock imgblock;

@end

