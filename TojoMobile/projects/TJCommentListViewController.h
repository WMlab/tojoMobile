//
//  TJCommentViewController.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TojoMobile-swift.h"

@interface TJCommentListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BreakOutToRefreshDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) BreakOutToRefreshView *refreshView;

- (void)setProjectId:(int)projectId;

@end
