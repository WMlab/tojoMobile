//
//  TJChatListViewController.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/5/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJChatListCell.h"

@interface TJChatListViewController : UITableViewController

- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;

@end
