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

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *collectButtom;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *attendButton;
@property (nonatomic, strong) TJProjectDetailViewModel *viewModel;

@end
