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
#import "EndDateView.h"
#import "ProjectBasicInfoView.h"
#import "ProjectDetailInfoView.h"
#import "ProjectCommentPartView.h"
#import "ProjectTeamPartView.h"

@interface TJProjectDetailViewController ()

@end

@implementation TJProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //top view
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 180)];
    [topView setImage:[UIImage imageNamed:@"titleImageTest.png"]];
    
    EndDateView *endDateView = [[EndDateView alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
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
    ProjectBasicInfoView *basicInfoView = [[ProjectBasicInfoView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+240)];
    [basicInfoView.projectTitleLabel setText:@"第一个项目"];
    [strechy addSubview:basicInfoView];
    
    //detial info
    itemStartY += 240;
    ProjectDetailInfoView *detailInfoView = [[ProjectDetailInfoView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+240)];
    [strechy addSubview:detailInfoView];
    
    //comment part
    itemStartY += 240;
    ProjectCommentPartView *commentPartView = [[ProjectCommentPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+240)];
    [strechy addSubview:commentPartView];
    
    //team part
    itemStartY += 240;
    ProjectTeamPartView *teamPartView = [[ProjectTeamPartView alloc] initWithFrame:CGRectMake(0, itemStartY, [UIScreen mainScreen].bounds.size.width, itemStartY+240)];
    [strechy addSubview:teamPartView];
    
    //set scrollable area (classic uiscrollview stuff)
    [strechy setContentSize:CGSizeMake(width, itemStartY)];
    
    
}

- (UILabel *)scrollViewItemWithY:(CGFloat)y andNumber:(int)num {
    UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 200)];
    [item setBackgroundColor:[UIColor blackColor]];
    [item setText:[NSString stringWithFormat:@"Item %d", num]];
    [item setTextAlignment:NSTextAlignmentCenter];
    [item setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:26]];
    [item setTextColor:[UIColor whiteColor]];
    return item;
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
