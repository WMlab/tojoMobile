//
//  TJCommentListCell.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJCommentListCell.h"

@implementation TJCommentListCell

@synthesize commentUserImg;

- (void)awakeFromNib {
    // Initialization code
    [commentUserImg.layer setMasksToBounds:YES];
    [commentUserImg.layer setCornerRadius:25];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithTeamItem:(TJCommentModel *)commentModel{
    
}

@end
