//
//  TJTeamListCell.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJTeamModel.h"

@interface TJTeamListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teamFounderImage;
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UILabel *teamFounderName;
@property (weak, nonatomic) IBOutlet UILabel *teamFounderUniversityName;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberNumber;

-(void)setCellWithTeamItem:(TJTeamModel *)teamModel;

@end
