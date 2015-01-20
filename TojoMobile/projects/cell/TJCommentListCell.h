//
//  TJCommentListCell.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJCommentModel.h"

@interface TJCommentListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentUserImg;
@property (weak, nonatomic) IBOutlet UILabel *commentUserName;
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (weak, nonatomic) IBOutlet UILabel *commentDate;

-(void)setCellWithTeamItem:(TJCommentModel *)commentModel;

@end
