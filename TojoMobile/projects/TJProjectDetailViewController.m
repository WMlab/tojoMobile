//
//  TJProjectDetailViewController.m
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectDetailViewController.h"
#import "StrechyParallaxScrollView.h"
#import <Masonry/Masonry.h>
#import "TJEndDateView.h"
#import "TJProjectBasicInfoView.h"
#import "TJProjectDetailInfoView.h"
#import "TJProjectCommentPartView.h"
#import "TJProjectTeamPartView.h"
#import "TJProjectInfoViewController.h"
#import "TJCommentViewController.h"
#import "TJCommentListViewController.h"
#import "TJTeamListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TJProjectSender.h"
#import <Masonry/Masonry.h>

@interface TJProjectDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *collectButtom;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *attendButton;
@property (nonatomic, strong) TJProjectDetailViewModel *viewModel;
@end

@implementation TJProjectDetailViewController{
    dispatch_once_t serviceOnce;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[TJProjectDetailViewModel alloc] init];
    [self loadProjectDetail];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.title = @"项目详情";
}

#pragma mark --------- 发服务 -----------
-(void) loadProjectDetail
{
    [[TJProjectSender getInstance] sendGetProjectDetailWithViewModel:_viewModel completeBlock:^(BOOL success, NSString *    message) {
        if (success) {
            NSLog(@"success");
            //页面进行赋值
            [self loadProjectDetail:_viewModel];
        }
        else {
            NSLog(@"falied");
        }
    }];
}

#pragma mark --------- 部署详情页面 -----------
- (void) loadProjectDetail:(TJProjectDetailViewModel*) viewModel{
    //top view
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TJScreenWidth, 3*TJScreenWidth/5)];
    [topView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.projectInfoModel.projectImage]]];
    
    TJEndDateView *endDateView = [[TJEndDateView alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    [endDateView.endDateLabel setText:@"2015/1/2"];//set end date
    [topView addSubview:endDateView];
    //masonary constraints for parallax view subviews (optional)
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 0, -40, 320);
    [endDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo ([NSValue valueWithCGSize:CGSizeMake(80, 33)]);
        //make.centerY.equalTo (topView);
        make.left.equalTo(topView).with.offset(padding.left);
        make.bottom.equalTo(topView).with.offset(padding.bottom);
    }];
    
    //create strechy parallax scroll view
    StrechyParallaxScrollView *strechy = [[StrechyParallaxScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49) andTopView:topView];
    [self.view addSubview:strechy];
    
    //basic info
    float itemStartY = topView.frame.size.height;
    TJProjectBasicInfoView *basicInfoView = [[TJProjectBasicInfoView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+200)];
    [basicInfoView.projectTitleLabel setText:viewModel.projectInfoModel.projectName];
    [basicInfoView.projectReleasedDateLabel setText:[NSString stringWithFormat:@"发布日期 %@", viewModel.projectInfoModel.projectCreatedDate]];
    [basicInfoView.projectFounderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.projectInfoModel.projectFounderImage]]];
    [basicInfoView.projectFounderLabel setText:viewModel.projectInfoModel.projectFounderName];
    [basicInfoView.projectFounderUniversityLabel setText:viewModel.projectInfoModel.projectFounderUniversityName];
    [strechy addSubview:basicInfoView];
    
    //detial info
    itemStartY += 200;
    TJProjectDetailInfoView *detailInfoView = [[TJProjectDetailInfoView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+200)];
    detailInfoView.projectDetailLabel.text = viewModel.projectInfoModel.projectText;
    [detailInfoView.allInfoButton addTarget:self action:@selector(allInfoButtonClicked)forControlEvents:UIControlEventTouchUpInside];
    [strechy addSubview:detailInfoView];
    
    //comment part
    itemStartY += 200;
    TJProjectCommentPartView *commentPartView = [[TJProjectCommentPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+290)];
    [commentPartView.commentCount setText:[NSString stringWithFormat:@"%d条评论", viewModel.projectInfoModel.commentNumber]];
    [commentPartView.latestCommentUserImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.commentModel.commentUserImage]]];
    [commentPartView.latestCommentUserName setText:viewModel.commentModel.commentUserName];
    [commentPartView.latestCommentDate setText:viewModel.commentModel.commentDate];
    [commentPartView.latestCommentText setText:viewModel.commentModel.commentText];
    [commentPartView.allCommentButton addTarget:self action:@selector(allCommentButtonClicked)forControlEvents:UIControlEventTouchUpInside];
    [strechy addSubview:commentPartView];
    
    //team part
    itemStartY += 290;
    TJProjectTeamPartView *teamPartView = [[TJProjectTeamPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+270)];
    [teamPartView.teamCount setText:[NSString stringWithFormat:@"%d个团队", viewModel.projectInfoModel.teamNumber]];
    [teamPartView.latestTeamFounderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.teamModel.teamFounderImage]]];
    [teamPartView.latestTeamName setText:viewModel.teamModel.teamName];
    [teamPartView.latestTeamFounderName setText:viewModel.teamModel.teamFounderName];
    [teamPartView.latestTeamFounderUniversity setText:viewModel.teamModel.teamFounderSchool];
    [teamPartView.latestTeamMemberNow setText:[NSString stringWithFormat:@"%d/%d", viewModel.teamModel.teamMemberNow,viewModel.teamModel.teamMemberAll]];
    [teamPartView.allTeamButton addTarget:self action:@selector(allTeamButtonClicked)forControlEvents:UIControlEventTouchUpInside];
    [strechy addSubview:teamPartView];
    
    //set scrollable area (classic uiscrollview stuff)
    itemStartY = itemStartY+270;
    [strechy setContentSize:CGSizeMake(TJScreenWidth, itemStartY)];
}

#pragma mark --------- 详情页面按钮跳转 -----------
- (void) allInfoButtonClicked{
    TJProjectInfoViewController *infoViewController = [[TJProjectInfoViewController alloc] init];
    
    [self.navigationController pushViewController:infoViewController animated:YES];
}

- (void) allCommentButtonClicked{
    TJCommentListViewController *commentListViewController = [[TJCommentListViewController alloc] init];
    
    [self.navigationController pushViewController:commentListViewController animated:YES];
}

- (void) allTeamButtonClicked{
    TJTeamListViewController *teamListViewController = [[TJTeamListViewController alloc] init];
    
    [self.navigationController pushViewController:teamListViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark --------- 下方Tab按钮跳转 -----------

- (IBAction)collectButtonClicked:(UIButton *)sender {
}

- (IBAction)commentButtonClicked:(UIButton *)sender {
    TJCommentViewController *commentViewController = [[TJCommentViewController alloc] init];
    
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (IBAction)attendButtonClicked:(UIButton *)sender {
    TJTeamListViewController *teamListViewController = [[TJTeamListViewController alloc] init];
    
    [self.navigationController pushViewController:teamListViewController animated:YES];
}
@end
