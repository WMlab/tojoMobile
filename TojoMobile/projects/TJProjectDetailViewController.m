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

@interface TJProjectDetailViewController ()

@end

@implementation TJProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //top view
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 180)];
    [topView setImage:[UIImage imageNamed:@"titleImageTest.png"]];
    
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
    [basicInfoView.projectTitleLabel setText:@"第一个项目"];
    [strechy addSubview:basicInfoView];
    
    //detial info
    itemStartY += 200;
    TJProjectDetailInfoView *detailInfoView = [[TJProjectDetailInfoView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+200)];
    detailInfoView.projectDetailLabel.text = @"我自己理解，「互联网本身是思维」，再延伸一句话，「互联网也是肉体」，要想跑得快你必须具备互联网的思维、互联网的肉体，但是你要想跑得久你需要灵魂，这个灵魂其实是对于传统业务的专业能力的把握和理解，这在电商，在比如互联网金融、互联网汽车等很多领域都是这样，一句话概括就是「别让肉体跑丢了灵魂，请保持对互联网的敬畏」当我们进入这些产业的时候，他们对这些产业的掌握、理解、能力、执行都是需要我们学习的。";
    [detailInfoView.allInfoButton addTarget:self action:@selector(allInfoButtonClicked)forControlEvents:UIControlEventTouchUpInside];
    [strechy addSubview:detailInfoView];
    
    //comment part
    itemStartY += 200;
    TJProjectCommentPartView *commentPartView = [[TJProjectCommentPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+320)];
    [strechy addSubview:commentPartView];
    
    //team part
    itemStartY += 320;
    TJProjectTeamPartView *teamPartView = [[TJProjectTeamPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+270)];
    [strechy addSubview:teamPartView];
    
    //set scrollable area (classic uiscrollview stuff)
    [strechy setContentSize:CGSizeMake(width, itemStartY)];
    
    
}

- (void) allInfoButtonClicked{
//    TJProjectInfoViewController *projectInfoVC = [[TJProjectInfoViewController alloc] init];
//    [self presentViewController:projectInfoVC animated:YES completion:Nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
