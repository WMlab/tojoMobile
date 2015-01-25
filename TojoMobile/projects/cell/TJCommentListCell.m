//
//  TJCommentListCell.m
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJCommentListCell.h"
#import "TJSystemParam.h"
#import <UIImageView+WebCache.h>

@implementation TJCommentListCell

@synthesize commentUserImg;

- (void)awakeFromNib {
    // Initialization code
    [commentUserImg.layer setMasksToBounds:YES];
    [commentUserImg.layer setCornerRadius:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithCommentItem:(TJCommentModel *)commentModel{
    [self.commentUserName setText:commentModel.commentUserName];
    [self.commentDate setText:commentModel.commentDate];
    [self.commentText setText:commentModel.commentText];
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_BASE_URL, commentModel.commentUserImage];
    [self.commentUserImg sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
}

@end
