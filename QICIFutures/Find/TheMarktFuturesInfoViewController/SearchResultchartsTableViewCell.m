//
//  SearchResultchartsTableViewCell.m
//  QCLC
//
//  Created by mac on 2019/5/27.
//

#import "SearchResultchartsTableViewCell.h"

@implementation SearchResultchartsTableViewCell
{
    NSArray *guoneiBtnTittle;
    NSArray *guowaiBtnTittle;
}

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
        
        guoneiBtnTittle = @[@"日K",@"5分钟",@"15分钟",@"30分钟",@"60分钟"];
        guowaiBtnTittle = @[@"日K"];
        
        [self configUI];
    }
    return self;
}

-(QCStockLineView *)kView{
    
    if (!_kView) {
        _kView = [[QCStockLineView alloc] instanceViewWithSize:CGSizeMake(SCREEN_WIDTH, 300)];
        _kView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    }
    return _kView;
}

-(AllFuturesTopBtnView *)btnView{
    
    if (!_btnView) {
        _btnView = [[AllFuturesTopBtnView alloc] initWithFrame:CGRectMake(0, 300, self.contentView.width, 40)];
    }
    
    return _btnView;
}

-(void)configUI{
    
    [self.contentView addSubview:self.kView];
}

-(void)refreshWithData:(NSArray *)dataArray type:(NSString *)type{
    
    [self.kView reloadData:dataArray];
    
    if (dataArray.count > 0) {
        if ([type isEqualToString:@"guonei"]) {
            [self.btnView refreshWithArray:guoneiBtnTittle];
            
        }else{
            [self.btnView refreshWithArray:guowaiBtnTittle];
            
        }
        
        weakSelf(weakSelf);
        
        self.btnView.btnClickBlock = ^(NSInteger index) {
            if (weakSelf.requestKLineType) {
                weakSelf.requestKLineType(index);
            }
        };
        [self addSubview:self.btnView];
    }
    
}

@end
