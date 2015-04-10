//
//  TJTeamViewController.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJTeamListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)createTeam:(UIButton *)sender;
- (IBAction)attendByOneself:(UIButton *)sender;

- (void)setProjectId:(int)projectId;

@end
