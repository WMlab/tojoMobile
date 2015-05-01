//
//  TJSettingTableViewController.m
//  TojoMobile
//
//  Created by sdq on 15/4/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJSettingTableViewController.h"
#import "TJUserMenuCell.h"
#import "TJLogoutTableViewCell.h"
#import "TJRevisePasswordViewController.h"
#import "TJAboutTongjoViewController.h"
#import "TJSession.h"

@interface TJSettingTableViewController () <UIActionSheetDelegate>

@end

@implementation TJSettingTableViewController{
    dispatch_once_t onceToken;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    self.navigationItem.title = @"设置";
    
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"TJUserMenuCell";
    static NSString *CellIdentifier2 = @"TJLogoutTableViewCell";
    [tableView registerNib:[UINib nibWithNibName:CellIdentifier1 bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier1];
    [tableView registerNib:[UINib nibWithNibName:CellIdentifier2 bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier2];
    TJUserMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    TJLogoutTableViewCell *logoutCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            [menuCell setCellWithItemText:@"修改密码"];
        }
        if(indexPath.row == 1){
            [menuCell setCellWithItemText:@"关于同舟"];
        }
        return menuCell;
    }else{
        return logoutCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
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

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TJRevisePasswordViewController *revisePasswordVC = [[TJRevisePasswordViewController alloc] init];
            [self.navigationController pushViewController:revisePasswordVC animated:YES];
        }
        if (indexPath.row == 1) {
            TJAboutTongjoViewController *aboutVC = [[TJAboutTongjoViewController alloc] init];
            aboutVC.url = [NSURL URLWithString:@"http://www.tongjo.com/about#/about"];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
    }
    if (indexPath.section == 1) {
        UIActionSheet *myActionSheet = [[UIActionSheet alloc] initWithTitle:@"确认退出？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil];
        [myActionSheet showInView:self.view];
    }
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[TJSession getInstance] clearUserInfoModel];
        [self.navigationController popToRootViewControllerAnimated:YES];
        //[[self navigationController] popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
