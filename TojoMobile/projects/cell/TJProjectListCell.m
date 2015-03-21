//
//  TJProjectListCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectListCell.h"
#import "TJSystemParam.h"

@interface TJProjectListCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainWidthFounderNameLabel;
@end

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
    NSString *founderNameAndUni = [NSString stringWithFormat:@"%@ %@",infoModel.projectFounderUniversityName, infoModel.projectFounderName];
    self.founderNameAndUniLabel.text = founderNameAndUni;
    CGRect rect = [founderNameAndUni boundingRectWithSize:CGSizeMake(MAXFLOAT, self.founderNameAndUniLabel.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.founderNameAndUniLabel.font} context:nil];
    self.constrainWidthFounderNameLabel.constant = rect.size.width;
    
    self.projectLabel.text = infoModel.projectLabel;
    self.teamNumberLabel.text = [NSString stringWithFormat:@"%d", infoModel.teamNumber];
    
    [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, infoModel.projectImage]]];
    [self.projectImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.projectImageView.clipsToBounds = YES;
    
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_BASE_URL, infoModel.projectFounderImage];
    [self.founderImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    self.founderImageView.layer.cornerRadius = self.founderImageView.frame.size.height/2;
    self.founderImageView.layer.masksToBounds = YES;
}

@end
