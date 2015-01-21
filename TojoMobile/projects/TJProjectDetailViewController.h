//
//  TJProjectDetailViewController.h
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJProjectDetailViewModel.h"

@interface TJProjectDetailViewController : UIViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) TJProjectDetailViewModel *projectDetailViewModel;
- (IBAction)collectButtonClicked:(UIButton *)sender;
- (IBAction)commentButtonClicked:(UIButton *)sender;
- (IBAction)attendButtonClicked:(UIButton *)sender;

@end
