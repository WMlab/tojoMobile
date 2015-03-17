//
//  ProjectDetailInfoView.m
//  TojoMobile
//
//  Created by sdq on 15/1/16.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectDetailInfoView.h"
#import <Masonry/Masonry.h>

@implementation TJProjectDetailInfoView

@synthesize projectDetailLabel;
@synthesize allInfoButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1.0]];
        
        //Introduce project
        UILabel *xiangMuJieShao;
        CGRect xiangMuJieShaoRect = CGRectMake(0, 0, 100, 30);
        xiangMuJieShao = [[UILabel alloc] initWithFrame:xiangMuJieShaoRect];
        xiangMuJieShao.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [xiangMuJieShao setText:@"项目介绍"];
        [xiangMuJieShao setFont:[UIFont boldSystemFontOfSize:17]];
        [self addSubview:xiangMuJieShao];
        [xiangMuJieShao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (23);
            make.centerX.equalTo (self);
        }];
        
        //detail
        CGRect projectDetailLabelRect = CGRectMake(0, 0, 100, 30);
        projectDetailLabel = [[UILabel alloc] initWithFrame:projectDetailLabelRect];
        projectDetailLabel.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [projectDetailLabel setText:@""];
        [projectDetailLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [self addSubview:projectDetailLabel];
        projectDetailLabel.textAlignment = NSTextAlignmentCenter;
        projectDetailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        projectDetailLabel.numberOfLines = 5;
        [projectDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo (self.mas_top).offset (55);
            make.centerX.equalTo (self);
        }];
        
        //button
        allInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allInfoButton.layer setMasksToBounds:YES];
        //[allInfoButton.layer setCornerRadius:10.0];//圆角
        [allInfoButton.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 30/255.0f, 195/255.0f, 153/255.0f, 1 });
        [allInfoButton.layer setBorderColor:colorref];
        [allInfoButton setTitle:@" 查看全部 " forState:UIControlStateNormal];
        [allInfoButton setTitleColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0] forState:UIControlStateNormal];
        //allInfoButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [self addSubview:allInfoButton];
        [allInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (150);
            make.centerX.equalTo (self);
        }];
        
        //line
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0]];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (199);
            make.bottom.equalTo (self.mas_top).offset (200);
            make.left.equalTo (self.mas_left).offset (10);
            make.right.equalTo (self.mas_right).offset (-10);
            make.centerX.equalTo (self);
        }];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
