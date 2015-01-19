//
//  TJProjectListCell.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJProjectInfoModel.h"
#import <UIImageView+WebCache.h>

@interface TJProjectListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *founderNameAndUniLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNumberLabel;

@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *founderImageView;
-(void)setCellWithProjectItem:(TJProjectInfoModel *)infoModel;

@end
