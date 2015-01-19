//
//  TJProjectListViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/11.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectListViewController.h"
#import "TJProjectListViewModel.h"
#import "TJProjectSender.h"
#import "TJProjectListCell.h"
#import "TJProjectDetailViewController.h"
#import <MJRefresh.h>

@interface TJProjectListViewController ()
@property (nonatomic, strong) TJProjectListViewModel *viewModel;
@end

@implementation TJProjectListViewController {
    dispatch_once_t onceToken;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[TJProjectListViewModel alloc] init];
    
    [self loadProjectList];
    //定义上拉、下拉加载数据
    [self updateDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSUInteger count = [_viewModel.projectList count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_once(&onceToken, ^{
        [tableView registerNib:[UINib nibWithNibName:@"TJProjectListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TJProjectListCell"];
    });
    static NSString *cellId = @"TJProjectListCell";
    TJProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    TJProjectInfoModel *infoModel = (TJProjectInfoModel *)[_viewModel.projectList objectAtIndex:indexPath.row];
    [cell setCellWithProjectItem:infoModel];

    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TJProjectDetailViewController *detailViewController = [[TJProjectDetailViewController alloc] init];
    detailViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//定义上拉下拉刷新数据的方法。
- (void)updateDataSource
{
    __block TJProjectListViewController *projectListVc = self;
    
    //下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [projectListVc loadProjectList];
    }];
    
    //上拉加载更多
    [self.tableView addFooterWithCallback:^{
//        [projectListVc upRefreshMoreData];
    }];
}


#pragma mark --------- 发服务 -----------
-(void) loadProjectList
{
    [[TJProjectSender getInstance] sendGetProjectListWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *message) {
        [self.tableView headerEndRefreshing];
        if (success) {
            NSLog(@"success");
            [self.tableView reloadData];
        }
        else {
            NSLog(@"falied");
        }
    }];
}

@end
