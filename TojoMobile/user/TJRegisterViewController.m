//
//  TJRegisterViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJRegisterViewController.h"
#import "TJTextFIeld.h"
#import "TJDefine.h"
#import <IQKeyboardManager.h>
#import "TJUserSender.h"
#import <ALToastView.h>

@interface TJRegisterViewController ()
@property (weak, nonatomic) IBOutlet TJTextFIeld *usernameTextField;
@property (weak, nonatomic) IBOutlet TJTextFIeld *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation TJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    self.usernameTextField.borderStyle = UITextBorderStyleNone;
    self.usernameTextField.layer.borderColor = TJColorHex(0x9e9e9f).CGColor;
    self.usernameTextField.layer.cornerRadius = 22;
    self.usernameTextField.layer.masksToBounds = YES;
    self.usernameTextField.layer.borderWidth = 0.5;
    self.usernameTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"person.png"]];
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.layer.borderColor = TJColorHex(0x9e9e9f).CGColor;
    self.passwordTextField.layer.cornerRadius = 22;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderWidth = 0.5;
    self.passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock.png"]];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.registerBtn.layer.cornerRadius = 22;
    self.registerBtn.backgroundColor = TJColorHex(0xcccccc);
    self.registerBtn.enabled = YES;
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)usernameEditingChanged:(id)sender {
    if (self.usernameTextField.text.length > 0 && self.passwordTextField.text.length >= 6) {
        self.registerBtn.backgroundColor = TJColorHex(0x1ec399);
        self.registerBtn.enabled = YES;
    }
    else {
        self.registerBtn.backgroundColor = TJColorHex(0xcccccc);
        self.registerBtn.enabled = NO;
    }
}
- (IBAction)passwordEditingChanged:(id)sender {
    if (self.usernameTextField.text.length > 0 && self.passwordTextField.text.length >= 6) {
        self.registerBtn.backgroundColor = TJColorHex(0x1ec399);
        self.registerBtn.enabled = YES;
    }
    else {
        self.registerBtn.backgroundColor = TJColorHex(0xcccccc);
        self.registerBtn.enabled = NO;
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

-(void) hideViewController {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{ }];
}
- (IBAction)registerAction:(id)sender {

    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [[TJUserSender getInstance] sendRegisterPostWithEmail:self.usernameTextField.text password:self.passwordTextField.text completeBlock:^(BOOL success, NSString *message) {
        if (!success) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [av show];
        }
        else {
            [ALToastView toastInView:self.view withText:@"注册成功"];
            [self performSelector:@selector(hideViewController) withObject:nil afterDelay:0.5];
        }
    }];
}

@end
