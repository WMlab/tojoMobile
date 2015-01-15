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

@interface TJProjectDetailViewController ()

@end

@implementation TJProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //top view
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 180)];
    [topView setImage:[UIImage imageNamed:@"titleImageTest.png"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, width, 20)];
    [label setText:@"Demo"];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [topView addSubview:label];
    
    //masonary constraints for parallax view subviews (optional)
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo ([NSValue valueWithCGSize:CGSizeMake(80, 80)]);
        make.centerX.equalTo (topView);
    }];
    
    //create strechy parallax scroll view
    
    StrechyParallaxScrollView *strechy = [[StrechyParallaxScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49) andTopView:topView];
    [self.view addSubview:strechy];
    
    //add dummy scroll view items
    float itemStartY = topView.frame.size.height;
    for (int i = 1; i <= 4; i++) {
        [strechy addSubview:[self scrollViewItemWithY:itemStartY andNumber:i]];
        itemStartY += 200;
    }
    
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
