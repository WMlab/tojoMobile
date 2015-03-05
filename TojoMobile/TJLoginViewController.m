//
//  FirstViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/5.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJLoginViewController.h"
#import "TJUserSender.h"
#import <ALToastView.h>
#import "TJDefine.h"
#import <IQKeyboardManager.h>

@interface TJLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation TJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"登录";
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(hideViewController)];
    self.navigationItem.rightBarButtonItem = createButton;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    self.usernameTextfield.borderStyle = UITextBorderStyleNone;
    self.usernameTextfield.layer.borderColor = TJColorHex(0x9e9e9f).CGColor;
    self.usernameTextfield.layer.cornerRadius = 22;
    self.usernameTextfield.layer.masksToBounds = YES;
    self.usernameTextfield.layer.borderWidth = 0.5;
    self.usernameTextfield.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"person.png"]];
    self.usernameTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextfield.borderStyle = UITextBorderStyleNone;
    self.passwordTextfield.layer.borderColor = TJColorHex(0x9e9e9f).CGColor;
    self.passwordTextfield.layer.cornerRadius = 22;
    self.passwordTextfield.layer.masksToBounds = YES;
    self.passwordTextfield.layer.borderWidth = 0.5;
    self.passwordTextfield.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock.png"]];
    self.passwordTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    self.loginBtn.layer.cornerRadius = 22;
    self.loginBtn.backgroundColor = TJColorHex(0xcccccc);
    self.loginBtn.enabled = YES;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)usernameEditingChanged:(id)sender {
    if (self.usernameTextfield.text.length > 0 && self.passwordTextfield.text.length > 0) {
        self.loginBtn.backgroundColor = TJColorHex(0x1ec399);
        self.loginBtn.enabled = YES;
    }
    else {
        self.loginBtn.backgroundColor = TJColorHex(0xcccccc);
        self.loginBtn.enabled = NO;
    }
}
- (IBAction)passwordEditingChanged:(id)sender {
    if (self.usernameTextfield.text.length > 0 && self.passwordTextfield.text.length > 0) {
        self.loginBtn.backgroundColor = TJColorHex(0x1ec399);
        self.loginBtn.enabled = YES;
    }
    else {
        self.loginBtn.backgroundColor = TJColorHex(0xcccccc);
        self.loginBtn.enabled = NO;
    }
}
- (IBAction)loginAction:(id)sender {
    [self.usernameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [[TJUserSender getInstance] sendUserLoginWithEmail:@"yy@tongjo.com" password:@"123" completeBlock:^(BOOL success, NSString *message) {
        if (!success) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [av show];
        }
        else {
            [ALToastView toastInView:self.view withText:@"登录成功"];
            [self performSelector:@selector(hideViewController) withObject:nil afterDelay:0.5];
        }
    }];
}

-(void) hideViewController {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{ }];
}

@end
