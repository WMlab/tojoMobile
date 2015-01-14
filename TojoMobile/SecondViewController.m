//
//  SecondViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/5.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "SecondViewController.h"
#import "TJProjectDetailViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /** Test for Project Detail **/
    TJProjectDetailViewController *TJProjectDetailVC = [[TJProjectDetailViewController alloc] init];
    [self presentViewController:TJProjectDetailVC animated:FALSE completion:Nil];
    /*****************************/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
