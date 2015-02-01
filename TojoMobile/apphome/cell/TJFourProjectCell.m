//
//  TJFourProjectCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJFourProjectCell.h"
#import <UIImageView+WebCache.h>
#import "TJDefine.h"
#import "TJSystemParam.h"
#import "TJProjectInfoModel.h"

@interface TJFourProjectCell ()
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView1;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView2;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView3;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView4;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel4;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainImageView1Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainImageView3Width;

@end
@implementation TJFourProjectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithProjects:(NSArray *)projectArr {
    self.projectArr = projectArr;
    [self setNeedsLayout];
    self.constrainImageView1Width.constant = TJScreenWidth/2;
    self.constrainImageView3Width.constant = TJScreenWidth/2;
    
    TJProjectInfoModel *model1 = (TJProjectInfoModel *)[projectArr objectAtIndex:0];
    [self.projectImageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, model1.projectImage]]];
    self.nameLabel1.text = model1.projectName;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProjectImage:)];
    [self.projectImageView1 addGestureRecognizer:tap1];
    self.projectImageView1.tag = 1;
    
    TJProjectInfoModel *model2 = (TJProjectInfoModel *)[projectArr objectAtIndex:1];
    [self.projectImageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, model2.projectImage]]];
    self.nameLabel2.text = model2.projectName;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProjectImage:)];
    [self.projectImageView2 addGestureRecognizer:tap2];
    self.projectImageView2.tag = 2;


    TJProjectInfoModel *model3 = (TJProjectInfoModel *)[projectArr objectAtIndex:2];
    [self.projectImageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, model3.projectImage]]];
    self.nameLabel3.text = model3.projectName;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProjectImage:)];
    [self.projectImageView3 addGestureRecognizer:tap3];
    self.projectImageView3.tag = 3;


    TJProjectInfoModel *model4 = (TJProjectInfoModel *)[projectArr objectAtIndex:3];
    [self.projectImageView4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL, model4.projectImage]]];
    self.nameLabel4.text = model4.projectName;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProjectImage:)];
    [self.projectImageView4 addGestureRecognizer:tap4];
    self.projectImageView4.tag = 4;

    
    [self layoutIfNeeded];
}

-(void)tapProjectImage:(UITapGestureRecognizer *) sender {
    TJProjectInfoModel *model = [_projectArr objectAtIndex:sender.view.tag - 1];
    [_delegate selectProjectWithModel:model];
}

@end
