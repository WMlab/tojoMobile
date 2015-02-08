//
//  TJCreateTeamViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJCreateTeamViewController.h"

@interface TJCreateTeamViewController ()
@property (weak, nonatomic) IBOutlet UITextField *teamName;
@property (weak, nonatomic) IBOutlet UITextField *teamMemberNumber;
@property (weak, nonatomic) IBOutlet UITextField *teamDeadlineDate;
@property (weak, nonatomic) IBOutlet UITextField *teamDescription;
@property (strong, nonatomic) UIDatePicker *datePicker;
@end

@implementation TJCreateTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.teamName.delegate = self;
    self.teamMemberNumber.delegate = self;
    self.teamDeadlineDate.delegate = self;
    self.teamDescription.delegate = self;
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"创建团队";
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:Nil action:@selector(createTeamMethod)];
    self.navigationItem.rightBarButtonItem = createButton;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];}

    //UIDatePicker

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTeamMethod{
    
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
