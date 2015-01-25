//
//  TestViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TestViewController.h"
#import "TJProjectDetailViewController.h"
#import "TJCommentListViewController.h"
#import "TJTeamListViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)projectDetailButton:(UIButton *)sender {
    TJProjectDetailViewController *detailViewController = [[TJProjectDetailViewController alloc] init];
    detailViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction)commentListButton:(UIButton *)sender {
    TJCommentListViewController *commentViewController = [[TJCommentListViewController alloc] init];
    commentViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (IBAction)teamListButton:(UIButton *)sender {
    TJTeamListViewController *teamViewController = [[TJTeamListViewController alloc] init];
    teamViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:teamViewController animated:YES];
}
@end
