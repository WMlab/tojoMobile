//
//  TJProjectInfoViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/18.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectInfoViewController.h"
#import "TJSystemParam.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TJProjectInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *projectInfoTableView;
@property (strong, nonatomic) IBOutlet UIView *projectInfoView;
@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *projectCreatedDate;
@property (weak, nonatomic) IBOutlet UILabel *projectFounderName;
@property (weak, nonatomic) IBOutlet UIImageView *projectImage;
@property (weak, nonatomic) IBOutlet UILabel *projectText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *projectTextHeight;
@property (weak, nonatomic) TJProjectInfoModel *projectInfoModel;


@end

@implementation TJProjectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"介绍";
    
    self.projectInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.projectInfoTableView.tableHeaderView = _projectInfoView;
    //self.projectInfoTableView.backgroundColor = RGBColor(245.0f, 245.0f, 245.0f);
    
    [self loadProjectInfoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 载入数据

-(void)loadProjectInfoView{
    CGFloat otherHeight = 450.0f;
    
    UIView * tableHeaderView = self.projectInfoView;
    
    
    //项目文本处理
    self.projectTitle.text = self.projectInfoModel.projectName;
    self.projectFounderName.text = self.projectInfoModel.projectFounderName;
    self.projectCreatedDate.text = self.projectInfoModel.projectCreatedDate;
    self.projectText.text = self.projectInfoModel.projectText;
    [self.projectImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, self.projectInfoModel.projectImage]]];
    CGSize projectTextSize = [self.projectText.text sizeWithFont:self.projectText.font constrainedToSize:CGSizeMake(TJScreenWidth-30.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    self.projectTextHeight.constant = ceilf(projectTextSize.height);
    
    tableHeaderView.frame = CGRectMake(self.projectInfoView.frame.origin.x, self.projectInfoView.frame.origin.y, self.projectInfoView.frame.size.width, ceilf(projectTextSize.height)+otherHeight);
    self.projectInfoView = tableHeaderView;
    self.projectInfoTableView.tableHeaderView = self.projectInfoView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //NSUInteger count = [_viewModel.projectList count];
    //return count;
    return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击团队
}

#pragma set/get
- (void)setInfoModel:(TJProjectInfoModel *)infoModel{

    self.projectInfoModel = infoModel;
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
