//
//  TJUserViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserViewController.h"
#import "TJLoginViewController.h"
#import "TJUserMenuCell.h"
#import "TJUserAttendProjectsViewController.h"
#import "TJUserAttendTeamsViewController.h"
#import "TJSettingTableViewController.h"
#import "TJUserBasicInfoCell.h"

@interface TJUserViewController ()

@end

@implementation TJUserViewController{
    dispatch_once_t onceToken;
}

@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationItem.title = @"我";
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = createButton;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    
    //configure tableview
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setting {
    TJSettingTableViewController *settingVC = [[TJSettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:TRUE];
}

- (void)showLogin{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *loginNav = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"loginNav"];
    
//    TJLoginViewController * loginVC = (TJLoginViewController *)[sb instantiateViewControllerWithIdentifier:@"loginVC"];
    [self presentViewController:loginNav animated:YES completion:^{}];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 0;
    if (section == 0) {
        row = 1;
    }else if(section == 1){
        row = 2;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier1 = @"TJUserMenuCell";
    static NSString *CellIdentifier2 = @"TJUserBasicInfoCell";
    //[self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [tableView registerNib:[UINib nibWithNibName:CellIdentifier1 bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier1];
    [tableView registerNib:[UINib nibWithNibName:CellIdentifier2 bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier2];
    TJUserMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    TJUserBasicInfoCell *userCell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    
    if (indexPath.section == 0) {
        return userCell;
    }else {
        if (indexPath.row == 0) {
            [menuCell setCellWithItemText:@"我参与的项目"];
        }
        if (indexPath.row == 1) {
            [menuCell setCellWithItemText:@"我参与的团队"];
        }
        return menuCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    } else {
        return 44;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    [self showLogin];
                }
                    break;
                    
                default:
                    break;
            }
            break;

        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    TJUserAttendProjectsViewController *attendProjectVC = [[TJUserAttendProjectsViewController alloc] init];
                    [self.navigationController pushViewController:attendProjectVC animated:YES];
                }
                    break;
                case 1:
                {
                    TJUserAttendTeamsViewController *attendTeamVC = [[TJUserAttendTeamsViewController alloc] init];
                    [self.navigationController pushViewController:attendTeamVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
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
