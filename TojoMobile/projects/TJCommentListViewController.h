//
//  TJCommentViewController.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJCommentListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

- (void)setProjectId:(NSString *)projectId;

@end
