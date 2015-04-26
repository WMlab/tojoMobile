//
//  TJRevisePasswordViewController.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/4/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJRevisePasswordViewController.h"
#import "TJTextFIeld.h"
#import <IQKeyboardManager.h>
#import "TJUserSender.h"
#import <ALToastView.h>
#import "TJSession.h"
#import <CommonCrypto/CommonDigest.h>

@interface TJRevisePasswordViewController ()
@property (weak, nonatomic) IBOutlet TJTextFIeld *oldPwdField;
@property (weak, nonatomic) IBOutlet TJTextFIeld *freshPwdField;
@property (weak, nonatomic) IBOutlet TJTextFIeld *freshPwdAgainField;

@end

@implementation TJRevisePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"修改密码";
    UIBarButtonItem *completeButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(changePwd)];
    self.navigationItem.rightBarButtonItem = completeButton;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];

    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [self.oldPwdField setTextFieldStyle:TEXTFIELD_TYPE_REVISE_PASSWORD];
    [self.freshPwdField setTextFieldStyle:TEXTFIELD_TYPE_REVISE_PASSWORD];
    [self.freshPwdAgainField setTextFieldStyle:TEXTFIELD_TYPE_REVISE_PASSWORD];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) changePwd {
    [self.oldPwdField resignFirstResponder];
    [self.freshPwdField resignFirstResponder];
    [self.freshPwdAgainField resignFirstResponder];
    
    if ([self checkInputValidate]) {
        int userId = [[TJSession getInstance] getUserId];
        [[TJUserSender getInstance] sendRevisePasswordWithUserId:userId oldPassword:[self md5:self.oldPwdField.text] andNewPassword:[self md5:self.freshPwdField.text] completeBlock:^(BOOL success, NSString *message) {
            if (success) {
                [ALToastView toastInView:self.view withText:@"修改成功"];
                //跳转到登陆页
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                [ALToastView toastInView:self.view withText:@"修改密码失败"];
            }
        }];
    }
}

- (BOOL) checkInputValidate {
    if (![self.freshPwdField.text isEqualToString:self.freshPwdAgainField.text]) {
        [ALToastView toastInView:self.view withText:@"两次输入的密码不一致"];
        return false;
    }
    else {
        return true;
    }
}

/**** md5码转换 ****/
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
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
