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

#define NAVBAR_CHANGE_POINT 50

@interface TJProjectDetailViewController (){
    int projectId;
    StrechyParallaxScrollView *strechy;
}

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
    
    viewModel = [[TJProjectDetailViewModel alloc] init];
    //发服务加载
    [[TJProjectSender getInstance] sendGetProjectDetailWithViewModel:viewModel projectId:projectId completeBlock:^(BOOL success, NSString *    message) {
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
            [strechy addSubview:commentPartView];
            
            //team part
            itemStartY += 290;
            TJProjectTeamPartView *teamPartView = [[TJProjectTeamPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+270)];
            [teamPartView.allTeamButton addTarget:self action:@selector(allTeamButtonClicked)forControlEvents:UIControlEventTouchUpInside];
            [strechy addSubview:teamPartView];
            
            //set scrollable area (classic uiscrollview stuff)
            itemStartY = itemStartY+270;
            [strechy setContentSize:CGSizeMake(TJScreenWidth, itemStartY)];
            
            
            //页面进行赋值
            //top view
//            [topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.projectInfoModel.projectImage]]];
            [topImageView startLoaderWithTintColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0]];
            [topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, viewModel.projectInfoModel.projectImage]] placeholderImage:nil options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [topImageView updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [topImageView reveal];
            }];
            
            [endDateView.endDateLabel setText:viewModel.projectInfoModel.projectEndDate];//set end date
            
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
    //单指单击
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate= self;
}

#pragma mark --------- 设置id -----------
- (void)setProjectId:(int)ID{
    projectId = ID;
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

#pragma mark --------- UIGestureRecognizerDelegate -----------
