//
//  TJUserTableViewController.m
//  TojoMobile
//
//  Created by sdq on 15/4/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserTableViewController.h"
#import "TJSession.h"
#import "TJUserBasicInfoModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TJSystemParam.h"
#import "TJUserAttendTeamsViewController.h"
#import "TJUserAttendProjectsViewController.h"

@interface TJUserTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userUniversity;
@property (strong, nonatomic) TJUserBasicInfoModel *userInfo;
@property BOOL isLogin;

@end

@implementation TJUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"我";
    
    self.userInfo = [[TJSession getInstance] getUserInfoModel];
    if (self.userInfo.userId == 0) {
        self.userName.text = @"您好！";
        self.userUniversity.text = @"请先登陆";
        [self.userAvatar setImage:[UIImage imageNamed:@"person"]];
        [self showLogin];
        self.isLogin = FALSE;
    }
    
    self.userAvatar.layer.masksToBounds = YES;
    self.userAvatar.layer.cornerRadius = 32;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    self.userInfo = [[TJSession getInstance] getUserInfoModel];
    if (self.userInfo.userId == 0) {
        self.userName.text = @"您好！";
        self.userUniversity.text = @"请先登陆";
        [self.userAvatar setImage:[UIImage imageNamed:@"person"]];
        self.isLogin = FALSE;
    } else {
        self.userName.text = self.userInfo.userRealName;
        self.userUniversity.text = self.userInfo.userUniversity;
        [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, self.userInfo.userImage]]];
        [self.tableView reloadData];
        self.isLogin = TRUE;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLogin{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *loginNav = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"loginNav"];
    
    //    TJLoginViewController * loginVC = (TJLoginViewController *)[sb instantiateViewControllerWithIdentifier:@"loginVC"];
    [self presentViewController:loginNav animated:YES completion:^{}];
}

#pragma mark - Table view datasource and delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isLogin) {
        if (indexPath.section == 0) {
            [self performSegueWithIdentifier:@"changeUserInfo" sender:self];
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                [self performSegueWithIdentifier:@"userProject" sender:self];
            }
            if (indexPath.row == 1) {
                [self performSegueWithIdentifier:@"userTeam" sender:self];
            }
        }
        if (indexPath.section == 2) {
            [self performSegueWithIdentifier:@"appSetting" sender:self];
        }
    } else {
        [self showLogin];
    }
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"userProject"]) {
        TJUserAttendProjectsViewController *projectVC = segue.destinationViewController;
        projectVC.userId = self.userInfo.userId;
    }
    if ([segue.identifier isEqualToString:@"userTeam"]) {
        TJUserAttendTeamsViewController *teamVC = segue.destinationViewController;
        teamVC.userId = self.userInfo.userId;
    }
}


@end
