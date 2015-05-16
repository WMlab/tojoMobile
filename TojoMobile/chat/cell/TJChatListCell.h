//
//  TJChatListCell.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/5/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EaseMob.h>
@interface TJChatListCell : UITableViewCell

-(void) setCellWithConversation:(EMConversation *)conversation;

@end
