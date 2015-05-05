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
#import <RJImageLoader/UIImageView+RJLoader.h>
#import "TJProjectSender.h"
#import <Masonry/Masonry.h>
#import "TJUserHomepageViewController.h"
#import "TJUserBasicInfoModel.h"
#import "TJSession.h"

#define NAVBAR_CHANGE_POINT 50

#define USER_IMAGE_PROJECT 101
#define USER_IMAGE_COMMENT 102
#define USER_IMAGE_TEAM 103

@interface TJProjectDetailViewController (){
    int projectId;
    StrechyParallaxScrollView *strechy;
}
@property (strong, nonatomic) TJUserBasicInfoModel *userInfo;

@end

@implementation TJProjectDetailViewController{
    dispatch_once_t serviceOnce;
}
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
    self.navigationItem.title = @"项目详情";
    
    self.userInfo = [[TJSession getInstance] getUserInfoModel];
    
    viewModel = [[TJProjectDetailViewModel alloc] init];
    //发服务加载
    [[TJProjectSender getInstance] sendGetProjectDetailWithViewModel:viewModel projectId:projectId completeBlock:^(BOOL success, NSString *message) {
        if (success) {
            NSLog(@"success");
            //页面结构载入
            //top view
            UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TJScreenWidth, 3*TJScreenWidth/5)];
            
            TJEndDateView *endDateView = [[TJEndDateView alloc] initWithFrame:CGRectMake(0, 0, 90, 33)];
            [topImageView addSubview:endDateView];
            //masonary constraints for parallax view subviews (optional)
            UIEdgeInsets padding = UIEdgeInsetsMake(10, 0, -40, 320);
            [endDateView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo ([NSValue valueWithCGSize:CGSizeMake(80, 33)]);
                //make.centerY.equalTo (topView);
                make.left.equalTo(topImageView).with.offset(padding.left);
                make.bottom.equalTo(topImageView).with.offset(padding.bottom);
            }];
            
            //create strechy parallax scroll view
            strechy = [[StrechyParallaxScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-64) andTopView:topImageView];
            [self.view addSubview:strechy];
            //basic info
            float itemStartY = topImageView.frame.size.height;
            TJProjectBasicInfoView *basicInfoView = [[TJProjectBasicInfoView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+200)];
            //添加头像点击手势
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserImage:)];
            [basicInfoView.projectFounderImg addGestureRecognizer:singleTap];
            basicInfoView.projectFounderImg.userInteractionEnabled = YES;
            basicInfoView.projectFounderImg.tag = USER_IMAGE_PROJECT;
            [strechy addSubview:basicInfoView];
            
            
            //detial info
            itemStartY += 200;
            TJProjectDetailInfoView *detailInfoView = [[TJProjectDetailInfoView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+200)];
            [detailInfoView.allInfoButton addTarget:self action:@selector(allInfoButtonClicked)forControlEvents:UIControlEventTouchUpInside];
            [strechy addSubview:detailInfoView];
            
            //comment part
            itemStartY += 200;
            TJProjectCommentPartView *commentPartView = [[TJProjectCommentPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+290)];
            [commentPartView.allCommentButton addTarget:self action:@selector(allCommentButtonClicked)forControlEvents:UIControlEventTouchUpInside];
            //添加头像点击手势
            UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserImage:)];
            [commentPartView.latestCommentUserImg addGestureRecognizer:singleTap2];
            commentPartView.latestCommentUserImg.userInteractionEnabled = YES;
            commentPartView.latestCommentUserImg.tag = USER_IMAGE_COMMENT;
            [strechy addSubview:commentPartView];
            
            //team part
            itemStartY += 290;
            TJProjectTeamPartView *teamPartView = [[TJProjectTeamPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+270)];
            [teamPartView.allTeamButton addTarget:self action:@selector(allTeamButtonClicked)forControlEvents:UIControlEventTouchUpInside];
            //添加头像点击手势
            UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserImage:)];
            [teamPartView.latestTeamFounderImg addGestureRecognizer:singleTap3];
            teamPartView.latestTeamFounderImg.userInteractionEnabled = YES;
            teamPartView.latestTeamFounderImg.tag = USER_IMAGE_TEAM;
            [strechy addSubview:teamPartView];
            
            //set scrollable area (classic uiscrollview stuff)
            itemStartY = itemStartY+270;
            [strechy setContentSize:CGSizeMake(TJScreenWidth, itemStartY)];
            
            
            //页面进行赋值
            //top view
            [topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.projectInfoModel.projectImage]]];
//            [topImageView startLoaderWithTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
//            [topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.projectInfoModel.projectImage]] placeholderImage:nil options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                [topImageView updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                [topImageView reveal];
//            }];
            [topImageView setContentMode:UIViewContentModeScaleAspectFill];
            
            NSString *endDateString = [viewModel.projectInfoModel.projectEndDate substringToIndex:10];
            [endDateView.endDateLabel setText:endDateString];//set end date
            
            [basicInfoView.projectTitleLabel setText:viewModel.projectInfoModel.projectName];
            [basicInfoView.projectReleasedDateLabel setText:[NSString stringWithFormat:@"发布日期 %@", viewModel.projectInfoModel.projectCreatedDate]];
            [basicInfoView.projectFounderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.projectInfoModel.projectFounderImage]]];
            [basicInfoView.projectFounderLabel setText:viewModel.projectInfoModel.projectFounderName];
            [basicInfoView.projectFounderUniversityLabel setText:viewModel.projectInfoModel.projectFounderUniversityName];
            //detial info
            detailInfoView.projectDetailLabel.text = viewModel.projectInfoModel.projectText;
            
            //comment part
            [commentPartView.commentCount setText:[NSString stringWithFormat:@"%d条评论", viewModel.projectInfoModel.commentNumber]];
            [commentPartView.latestCommentUserImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.commentModel.commentUserImage]]];
            [commentPartView.latestCommentUserName setText:viewModel.commentModel.commentUserName];
            [commentPartView.latestCommentDate setText:viewModel.commentModel.commentDate];
            [commentPartView.latestCommentText setText:viewModel.commentModel.commentText];
            
            //team part
            [teamPartView.teamCount setText:[NSString stringWithFormat:@"%d个团队", viewModel.projectInfoModel.teamNumber]];
            [teamPartView.latestTeamFounderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.teamModel.teamFounderImage]]];
            [teamPartView.latestTeamName setText:viewModel.teamModel.teamName];
            [teamPartView.latestTeamFounderName setText:viewModel.teamModel.teamFounderName];
            [teamPartView.latestTeamFounderUniversity setText:viewModel.teamModel.teamFounderSchool];
            [teamPartView.latestTeamMemberNow setText:[NSString stringWithFormat:@"%d/%d", viewModel.teamModel.teamMemberNow,viewModel.teamModel.teamMemberAll]];
        }
        else {
            NSLog(@"falied");
        }
    }];
}

#pragma mark --------- 设置id -----------
- (void)setProjectId:(int)ID{
    projectId = ID;
}

-(void)tapUserImage:(UITapGestureRecognizer *) sender
{
    NSInteger tag = sender.view.tag;
    int userId = 0;
    if (tag == USER_IMAGE_PROJECT) {
        userId = viewModel.projectInfoModel.projectFounderId;
    }
    else if(tag == USER_IMAGE_COMMENT) {
        userId = viewModel.commentModel.commentUserId;
    }
    else if (tag == USER_IMAGE_TEAM) {
        userId = viewModel.teamModel.teamFounderId;
    }
    TJUserHomepageViewController *userHomeVC = [[TJUserHomepageViewController alloc] init];
    [userHomeVC setUserId:userId];
    [self.navigationController pushViewController:userHomeVC animated:YES];
}

#pragma mark --------- 详情页面按钮跳转 -----------
- (void) allInfoButtonClicked{
    if (self.userInfo.userId == 0) {
        [self showLogin];
    } else {
        TJProjectInfoViewController *infoViewController = [[TJProjectInfoViewController alloc] init];
        [infoViewController setInfoModel:viewModel.projectInfoModel];
        [self.navigationController pushViewController:infoViewController animated:YES];
    }
    
}

- (void) allCommentButtonClicked{
    if (self.userInfo.userId == 0) {
        [self showLogin];
    } else {
        TJCommentListViewController *commentListViewController = [[TJCommentListViewController alloc] init];
        [commentListViewController setProjectId:projectId];
        [self.navigationController pushViewController:commentListViewController animated:YES];
    }
    
}

- (void) allTeamButtonClicked{
    if (self.userInfo.userId == 0) {
        [self showLogin];
    } else {
        TJTeamListViewController *teamListViewController = [[TJTeamListViewController alloc] init];
        [teamListViewController setProjectId:projectId];
        
        [self.navigationController pushViewController:teamListViewController animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark --------- 下方Tab按钮跳转 -----------

- (IBAction)commentButtonClicked:(UIButton *)sender {
    if (self.userInfo.userId == 0) {
        [self showLogin];
    } else {
        TJCommentViewController *commentViewController = [[TJCommentViewController alloc] init];
        
        [self.navigationController pushViewController:commentViewController animated:YES];
    }
    
    
}

- (IBAction)attendButtonClicked:(UIButton *)sender {
    if (self.userInfo.userId == 0) {
        [self showLogin];
    } else {
        TJTeamListViewController *teamListViewController = [[TJTeamListViewController alloc] init];
        
        [self.navigationController pushViewController:teamListViewController animated:YES];
    }
    
    
}

#pragma mark - login
- (void)showLogin{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *loginNav = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"loginNav"];
    
    //    TJLoginViewController * loginVC = (TJLoginViewController *)[sb instantiateViewControllerWithIdentifier:@"loginVC"];
    [self presentViewController:loginNav animated:YES completion:^{}];
}

@end

