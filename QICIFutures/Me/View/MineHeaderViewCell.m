#import "MineHeaderViewCell.h"
#import "UIView+CornerRadiusLayer.h"
#import "UIColor+Category.h"
#define ScaleHeight SCREEN_HEIGHT / 667
@interface MineHeaderViewCell ()

@property (nonatomic,strong)UIView *back;

@end

@implementation MineHeaderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_backImage) {
            _backImage = [UIImageView new];
            [self.contentView addSubview:_backImage];
            _backImage.userInteractionEnabled = YES;
//            [_backImage setImage:[[UIImage imageNamed:@"pic-1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [_backImage setImage:[UIImage imageNamed:@"pic-1"]];
            [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_offset(0);
                make.height.mas_offset(180);
            }];
        }
        if (!_title) {
            _title = [[UILabel alloc] init];
            [self.contentView addSubview:_title];
            [_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(kDeviceStatusHeight+20);
                make.centerX.equalTo(self);
            }];
            _title.textColor = [UIColor whiteColor];
            _title.font = [UIFont systemFontOfSize:18];
            _title.text = @"我的";
        }
        if (!_back) {
            _back = [[UIView alloc] init];
            _back.userInteractionEnabled = YES;
            [self.contentView addSubview:_back];
            [_back mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(95*ScaleHeight);
                make.left.mas_offset(24);
                make.right.mas_offset(-24);
                make.bottom.mas_offset(0);
            }];
            
            [_back setLayerCornerRadius:16 borderWidth:0 borderColor:nil];
            _back.backgroundColor = [UIColor mainColor];
        }
        if (!_header) {
            _header = [UIImageView new];
            _header.image = [UIImage imageNamed:@"head"];
            [self.contentView addSubview:self.header];
            [_header mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.width.height.mas_offset(83);
                make.top.mas_equalTo(self.title.mas_bottom).mas_offset(15);
            }];
            [_header setLayerCornerRadius:83 / 2 borderWidth:0 borderColor:nil];
            _header.userInteractionEnabled = YES;
        }
        if (!_name) {
            _name = [UILabel new];
            [self.back addSubview:_name];
            [_name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.mas_equalTo(self.header.mas_bottom).mas_offset(15);
            }];
            
            if ([[UserModel getInstance]getUserIsLogin]) {
                _name.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginnumber"];
            }else{
                _name.text = @"请注册/登陆";
            }
            _name.textColor = [UIColor textColorWithType:0];
            _name.font = [UIFont systemFontOfSize:16];
            _name.textAlignment = NSTextAlignmentCenter;
            _name.userInteractionEnabled = YES;
        }
        if (!_tip) {
            _tip = [UILabel new];
            [self.back addSubview:_tip];
            [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.mas_equalTo(self.name.mas_bottom).mas_offset(10);
            }];
            _tip.textColor = [UIColor textColorWithType:1];
            _tip.font = [UIFont systemFontOfSize:12];
            _tip.text = @"欢迎来到数字期货通";
            _tip.textAlignment = NSTextAlignmentCenter;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}


@end
