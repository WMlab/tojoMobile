//
//  TJCommentViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJCommentViewController.h"

@interface TJCommentViewController ()

@end

@implementation TJCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"评论";
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:Nil action:@selector(postCommentMethod)];
    self.navigationItem.rightBarButtonItem = postButton;
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postCommentMethod{
    
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
