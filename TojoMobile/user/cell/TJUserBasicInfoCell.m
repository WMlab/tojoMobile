//
//  TJUserBasicInfoCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserBasicInfoCell.h"
#import "TJSystemParam.h"
#import <UIImageView+WebCache.h>

@interface TJUserBasicInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSchoolLabel;
@end

@implementation TJUserBasicInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellWithModel:(TJUserBasicInfoModel *)infoModel {
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, infoModel.userImage]]];
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2;
    self.userImageView.layer.masksToBounds = YES;

    self.userNameLabel.text = infoModel.userRealName;
    self.userSchoolLabel.text = infoModel.userUniversity;
}

@end
