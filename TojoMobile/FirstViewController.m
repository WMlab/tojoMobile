//
//  FirstViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/5.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "FirstViewController.h"
#import "TJUserSender.h"
#import <ALToastView.h>
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    [[TJUserSender getInstance] sendUserLoginWithEmail:@"yy@tongjo.com" password:@"123" completeBlock:^(BOOL success, NSString *message) {
        if (!success) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [av show];
        }

        else {
            [ALToastView toastInView:self.view withText:@"登录成功"];
        }
    }];
}


@end
