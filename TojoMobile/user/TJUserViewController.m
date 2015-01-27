//
//  TJUserViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserViewController.h"
#import "TJLoginViewController.h"
@interface TJUserViewController ()

@end

@implementation TJUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showLogin:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *loginNav = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"loginNav"];
    
//    TJLoginViewController * loginVC = (TJLoginViewController *)[sb instantiateViewControllerWithIdentifier:@"loginVC"];
    [self presentViewController:loginNav animated:YES completion:^{}];
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
