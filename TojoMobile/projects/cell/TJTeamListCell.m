//
//  TJTeamListCell.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTeamListCell.h"
#import "TJSystemParam.h"
#import <UIImageView+WebCache.h>

@implementation TJTeamListCell

@synthesize teamFounderImage;

- (void)awakeFromNib {
    // Initialization code
    [teamFounderImage.layer setMasksToBounds:YES];
    [teamFounderImage.layer setCornerRadius:25];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithTeamItem:(TJTeamModel *)teamModel{
    [self.teamName setText:teamModel.teamName];
    [self.teamFounderName setText:teamModel.teamFounderName];
    [self.teamFounderUniversityName setText:teamModel.teamFounderSchool];
    [self.teamMemberNumber setText:[NSString stringWithFormat:@"%d/%d",teamModel.teamMemberNow,teamModel.teamMemberAll]];
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_BASE_URL, teamModel.teamFounderImage];
    [self.teamFounderImage sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
}

@end
