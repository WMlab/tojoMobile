//
//  TJCreateTeamViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJCreateTeamViewController.h"
#import "UUDatePicker.h"

@interface TJCreateTeamViewController ()

@end

@implementation TJCreateTeamViewController

@synthesize teamName;
@synthesize teamEndDate;
@synthesize teamMemberCount;
@synthesize teamIntroduce;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.teamName.delegate = self;
    self.teamMemberCount.delegate = self;
    self.teamEndDate.delegate = self;
    self.teamIntroduce.delegate = self;
    //导航栏
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"创建团队";
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:Nil action:@selector(createTeamMethod)];
    self.navigationItem.rightBarButtonItem = createButton;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    
    
    //DatePicker
    UUDatePicker *datePicker
    = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, 320, 200)
                             PickerStyle:1
                             didSelected:^(NSString *year,NSString *month,NSString *day,
                                           NSString *hour,NSString *minute,NSString *weekDay, NSString *count){
                                    teamEndDate.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
                                 }];
    teamEndDate.inputView = datePicker;
    NSDate *now = [NSDate date];
    datePicker.ScrollToDate = now;
    
    //MemberCountPicker
    UUDatePicker *countPicker
    = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, 320, 200)
                             PickerStyle:4
                             didSelected:^(NSString *year,NSString *month,NSString *day,
                                           NSString *hour,NSString *minute,NSString *weekDay, NSString *count){
                                 teamMemberCount.text = [NSString stringWithFormat:@"%@",count];
                             }];
    teamMemberCount.inputView = countPicker;

}


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
