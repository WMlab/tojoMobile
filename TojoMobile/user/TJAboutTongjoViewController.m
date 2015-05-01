//
//  TJAboutTongjoViewController.m
//  TojoMobile
//
//  Created by sdq on 15/4/30.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJAboutTongjoViewController.h"

@interface TJAboutTongjoViewController ()

@end

@implementation TJAboutTongjoViewController

@synthesize webContent;
@synthesize url;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"关于同舟";
    
    if (url) {
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [self.webContent loadRequest:request];
    }
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

@end
