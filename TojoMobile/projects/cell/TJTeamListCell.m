//
//  TJTeamListCell.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTeamListCell.h"

@implementation TJTeamListCell

@synthesize teamFounderImage;

- (void)awakeFromNib {
    // Initialization code
    [teamFounderImage.layer setMasksToBounds:YES];
    [teamFounderImage.layer setCornerRadius:30];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithTeamItem:(TJTeamModel *)teamModel{
    
}

@end
