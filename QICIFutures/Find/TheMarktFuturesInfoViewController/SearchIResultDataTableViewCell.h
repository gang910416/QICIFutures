//
//  SearchIResultDataTableViewCell.h
//  QCLC
//
//  Created by mac on 2019/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchIResultDataTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *openLabel;
@property (nonatomic,strong) UILabel *highLabel;
@property (nonatomic,strong) UILabel *lowLabel;
@property (nonatomic,strong) UILabel *jiesuanLabel;
@property (nonatomic,strong) UILabel *chicangabel;
@property (nonatomic,strong) UILabel *rizeLabel;

-(void)refreshWithDatas:(NSArray *)array isGuonei:(BOOL)isGuonei;

@end

NS_ASSUME_NONNULL_END
