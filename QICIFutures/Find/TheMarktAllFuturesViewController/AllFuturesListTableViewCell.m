//
//  AllFuturesListTableViewCell.m
//  QCLC
//
//  Created by mac on 2019/5/24.
//

#import "AllFuturesListTableViewCell.h"

@implementation AllFuturesListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
//    self.contentView.layer.masksToBounds = YES;
//    self.contentView.layer.cornerRadius = 6;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view setRadius:6 borderWidth:0 borderColor:nil];
    
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(60);
    }];
    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView setImage:imageWithString(@"箭头_右")];
//    [view addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(view).mas_offset(-10);
//        make.centerY.mas_equalTo(view);
//        make.width.mas_equalTo(12);
//        make.height.mas_equalTo(15);
//    }];
    
    [view addSubview:self.titleLabel];
    [view addSubview:self.idLabel];
    [view addSubview:self.infoLabel];
    [view addSubview:self.priceInfo];
    [view addSubview:self.priceLabel];
//    self.priceInfo.hidden = YES;
    self.priceLabel.hidden = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).mas_offset(-30);
        make.top.mas_equalTo(view.mas_centerY).mas_offset(3);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).mas_offset(-30);
        make.bottom.mas_equalTo(view.mas_centerY).mas_offset(-3);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_centerY).mas_offset(3);
        make.centerX.mas_equalTo(view);
    }];
    
    [self.priceInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_centerY).mas_offset(-3);
        make.centerX.mas_equalTo(view);
    }];
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

-(UILabel *)idLabel{
    
    if (!_idLabel) {
        _idLabel = [[UILabel alloc] init];
        _idLabel.textColor = [UIColor darkGrayColor];
        _idLabel.font = [UIFont systemFontOfSize:12];
        _idLabel.textAlignment = NSTextAlignmentRight;
    }
    return _idLabel;
}

-(UILabel *)infoLabel{
    
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"期货代码";
        _infoLabel.textColor = [UIColor lightGrayColor];
        _infoLabel.font = [UIFont systemFontOfSize:12];
    }
    return _infoLabel;
}

-(UILabel *)priceLabel{
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _priceLabel;
}

-(UILabel *)priceInfo{
    
    if (!_priceInfo) {
        _priceInfo = [[UILabel alloc] init];
        _priceInfo.textColor = [UIColor darkGrayColor];
        _priceInfo.font = [UIFont systemFontOfSize:13];
        _priceInfo.text = @"当前价";
    }
    return _priceInfo;
}

-(void)buildWithInfo:(NSDictionary *)dic{
    
    self.priceLabel.text = @"";
    
    if([dic objectForKey:@"name"] && [dic objectForKey:@"symbol"]){
        
        self.titleLabel.text = [dic objectForKey:@"name"];
        self.idLabel.text = [dic objectForKey:@"symbol"];
//        [self requestInfo:dic[@"symbol"]];
        self.fuId = [dic objectForKey:@"symbol"];
        
    }else if(dic.allKeys.count == 1){
        self.titleLabel.text = dic.allValues.firstObject;
        self.idLabel.text = dic.allKeys.firstObject;
//        [self requestInfo:dic.allKeys.firstObject];
        self.fuId = dic.allKeys.firstObject;
    }
    
}

-(void)requestInfos{
    
//    if (self.priceLabel.text.length > 0) {
//        return;
//    }
    
    if (self.fuId.length > 0) {
        
        if ([SaveAndUseFuturesDataModel getCodeIsDomestic:self.fuId]) {
            NSDictionary *param = @{@"code":self.fuId,@"token":tokenKey};
            
            [[HttpRequest sharedInstance] oneGet:@"" path:@"http://data.api51.cn/apis/multi_real/" parameters:param success:^(id responsData) {
                
                NSArray *arr = [self finishingData:responsData];
                
                if (arr.count > 0) {
                    NSArray *array = arr[0];
                    if (array.count > 9) {
                        NSString *price = array[9];
                        self.priceLabel.text = price;
                        self.priceInfo.hidden = NO;
                        self.priceLabel.hidden = NO;
                    }
                }
                
            } faile:^(NSError *error) {
                
            }];
        }else{
            NSDictionary *param = @{@"code":[NSString stringWithFormat:@"hf_%@",self.fuId],@"token":tokenKey};
            
            [[HttpRequest sharedInstance] oneGet:@"" path:@"http://data.api51.cn/apis/multi_real/" parameters:param success:^(id responsData) {
                
                NSArray *arr = [self finishingData:responsData];
                if (arr.count > 0) {
                    NSArray *array = arr[0];
                    if (array.count > 0) {
                        NSString *price = array[0];
                        self.priceLabel.text = price;
                        self.priceInfo.hidden = NO;
                        self.priceLabel.hidden = NO;
                    }
                    
                }
                
            } faile:^(NSError *error) {
                
            }];
        }
    }
    
}

-(NSArray *)finishingData:(NSData *)data{
    
    NSMutableArray *finalArray = [NSMutableArray array];
    
    NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:data encoding:enc];
    
    NSArray *strArray = [str componentsSeparatedByString:@"\n"];
    
    for (NSString *temp in strArray) {
        NSArray *array = [temp componentsSeparatedByString:@","];
        [finalArray addObject:array];
    }
    
    return finalArray;
}

@end
