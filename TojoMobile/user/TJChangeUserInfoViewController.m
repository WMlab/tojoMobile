//
//  TJChangeUserInfoViewController.m
//  TojoMobile
//
//  Created by sdq on 15/5/1.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJChangeUserInfoViewController.h"
#import "TJSession.h"
#import "TJSystemParam.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TJChangeUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userGender;
@property (weak, nonatomic) IBOutlet UILabel *userUniversity;

@end

@implementation TJChangeUserInfoViewController

@synthesize userInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"基本信息";
    
    self.userInfo = [[TJSession getInstance] getUserInfoModel];
    self.userName.text = self.userInfo.userRealName;
    if (self.userInfo.userGender == 1) {
        self.userGender.text = @"男";
    } else {
        self.userGender.text = @"女";
    }
    self.userUniversity.text = self.userInfo.userUniversity;
    self.userAvatar.layer.masksToBounds = YES;
    self.userAvatar.layer.cornerRadius = 32;
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, self.userInfo.userImage]]];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
