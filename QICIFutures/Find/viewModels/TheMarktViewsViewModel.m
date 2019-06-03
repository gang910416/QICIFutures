//
//  TheMarktViewsViewModel.m
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import "TheMarktViewsViewModel.h"
#import "TheMarktLearnsTableViewCell.h"
#import "TheMarktOthersTableViewCell.h"
#import "TheMarktLookFuturesCell.h"
#import "TheMarktAllFuturesViewController.h"

@implementation TheMarktViewsViewModel


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            return 80;
        }
            break;
        case 1:
        {
            return 170;
        }
        case 2:
        {
            return 150;
        }
        case 3:
        {
            return 70;
        }
            
        default:
            return 1;
            break;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 3) {
        return 2;
    }else{
       return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return nil;
    switch (indexPath.section) {
        case 0:
        {
            return [self NewsCellWithTableView:tableView indexPath:indexPath];
        }
            break;
        case 1:
        {
            return [self LearnCellWithTableView:tableView indexPath:indexPath];
        }
        case 2:
        {
            return [self OtherCellWithTableView:tableView indexPath:indexPath];
        }
        case 3:
        {
            return [self LookFuturesCellWithTableView:tableView indexPath:indexPath];
        }
            
        default:
            return nil;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath viewController:(UIViewController *)vc{
    
    if (indexPath.section == 3) {
        TheMarktAllFuturesViewController *tmafVC = [[TheMarktAllFuturesViewController alloc] init];
        
        if (indexPath.row == 0) {
            tmafVC.type = TheMarktAllFuturesViewTypeDomestic;
            tmafVC.title = @"国内期货";
        }else{
            tmafVC.type = TheMarktAllFuturesViewTypeForegin;
            tmafVC.title = @"国际期货";
        }
        
        [vc.navigationController pushViewController:tmafVC animated:YES];
    }
}

-(TheMarktScrollNewsTableViewCell *)NewsCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    TheMarktScrollNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheMarktScrollNewsTableViewCell"];
    if (!cell) {
        cell = [[TheMarktScrollNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TheMarktScrollNewsTableViewCell"];
    }
    
    return cell;
}

-(TheMarktLearnsTableViewCell *)LearnCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    TheMarktLearnsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheMarktLearnsTableViewCell"];
    if (!cell) {
        cell = [[TheMarktLearnsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TheMarktLearnsTableViewCell"];
    }
    weakSelf(self);
    cell.jumpToLearnView = ^{
        if (weakSelf.jumpToLearnView) {
            weakSelf.jumpToLearnView();
        }
    };
    
    return cell;
}

-(TheMarktOthersTableViewCell *)OtherCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    TheMarktOthersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheMarktOthersTableViewCell"];
    
    if (!cell) {
        cell = [[TheMarktOthersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TheMarktOthersTableViewCell"];
    }
    
    weakSelf(self);
    cell.othersBtnClickBlock = ^(NSInteger index) {
        if (weakSelf.othersBlock) {
            weakSelf.othersBlock(index);
        }
    };
    
    return cell;
}

-(TheMarktLookFuturesCell *)LookFuturesCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    TheMarktLookFuturesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheMarktLookFuturesCell"];
    
    if (!cell) {
        cell = [[TheMarktLookFuturesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TheMarktLookFuturesCell"];
    }
    
    if (indexPath.row == 0) {
        [cell buildWithTitle:@"查看国内期货" body:@"国内风雨.纵横捭阖" backColor:RGBColor(254, 215, 135)];
    }else{
        [cell buildWithTitle:@"查看国际期货" body:@"风云际会.金鳞岂是池中物" backColor:RGBColor(99, 185, 135)];
    }
    
    return cell;
}

@end
