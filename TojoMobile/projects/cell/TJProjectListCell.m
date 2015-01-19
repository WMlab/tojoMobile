//
//  TJProjectListCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectListCell.h"
#import "TJSystemParam.h"

@implementation TJProjectListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}

- (void)setCellWithProjectItem:(TJProjectInfoModel *)infoModel
{
    self.projectNameLabel.text = infoModel.projectName;
    self.projectEndDateLabel.text = [infoModel.projectEndDate substringWithRange:NSMakeRange(0, 10)];
    self.founderNameAndUniLabel.text = [NSString stringWithFormat:@"%@ %@",infoModel.projectFounderUniversityName, infoModel.projectFounderName];
    self.projectLabel.text = infoModel.projectLabel;
    
    [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, infoModel.projectImage]]];
    
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_BASE_URL, infoModel.projectFounderImage];
    [self.founderImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    self.founderImageView.layer.cornerRadius = self.founderImageView.frame.size.height/2;
    self.founderImageView.layer.masksToBounds = YES;
}

@end
