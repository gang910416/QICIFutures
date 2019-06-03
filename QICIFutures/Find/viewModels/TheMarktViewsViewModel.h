//
//  TheMarktViewsViewModel.h
//  QICIFutures
//
//  Created by mac on 2019/6/1.
//

#import <Foundation/Foundation.h>
#import "TheMarktScrollNewsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheMarktViewsViewModel : NSObject

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath viewController:(UIViewController *)vc;

@property (nonatomic,copy) void(^jumpToLearnView)(void);

@property (nonatomic,copy) void(^othersBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
