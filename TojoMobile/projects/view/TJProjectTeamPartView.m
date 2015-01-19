//
//  ProjectTeamPartView.m
//  TojoMobile
//
//  Created by sdq on 15/1/16.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectTeamPartView.h"
#import <Masonry/Masonry.h>

@implementation TJProjectTeamPartView

@synthesize teamCount;
@synthesize latestTeamFounderImg;
@synthesize latestTeamFounderName;
@synthesize latestTeamName;
@synthesize latestTeamFounderUniversity;
@synthesize latestTeamMemberNow;
@synthesize allTeamButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1.0]];
        
        //team count
        CGRect teamCountRect = CGRectMake(0, 0, 100, 30);
        teamCount = [[UILabel alloc] initWithFrame:teamCountRect];
        teamCount.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [teamCount setFont:[UIFont boldSystemFontOfSize:20]];
        [self addSubview:teamCount];
        [teamCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (20);
            make.centerX.equalTo (self);
        }];
        
        //team founder image
        latestTeamFounderImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [latestTeamFounderImg.layer setMasksToBounds:YES];
        [latestTeamFounderImg.layer setCornerRadius:30];
        [self addSubview:latestTeamFounderImg];
        [latestTeamFounderImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (55);
            make.bottom.equalTo(self.mas_top).offset(115);
            make.left.equalTo(self.mas_left).offset([UIScreen mainScreen].bounds.size.width/2-30);
            make.right.equalTo(self.mas_right).offset(-[UIScreen mainScreen].bounds.size.width/2+30);
            make.centerX.equalTo (self);
        }];
        
        //team name
        CGRect latestTeamNameRect = CGRectMake(0, 0, 100, 30);
        latestTeamName = [[UILabel alloc] initWithFrame:latestTeamNameRect];
        latestTeamName.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [latestTeamName setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:latestTeamName];
        [latestTeamName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (125);
            make.centerX.equalTo (self);
        }];
        
        //team founder name
        CGRect latestCommentDateRect = CGRectMake(0, 0, 100, 30);
        latestTeamFounderName = [[UILabel alloc] initWithFrame:latestCommentDateRect];
        latestTeamFounderName.textColor = [UIColor colorWithRed:113/255.0f green:113/255.0f blue:113/255.0f alpha:1.0];
        [latestTeamFounderName setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:latestTeamFounderName];
        [latestTeamFounderName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (145);
            make.centerX.equalTo (self);
        }];
        
        //team founder university
        CGRect latestTeamFounderUniversityRect = CGRectMake(0, 0, 100, 30);
        latestTeamFounderUniversity = [[UILabel alloc] initWithFrame:latestTeamFounderUniversityRect];
        latestTeamFounderUniversity.textColor = [UIColor colorWithRed:113/255.0f green:113/255.0f blue:113/255.0f alpha:1.0];
        [latestTeamFounderUniversity setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:latestTeamFounderUniversity];
        [latestTeamFounderUniversity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (165);
            make.centerX.equalTo (self);
        }];
        
        //team member
        CGRect latestTeamMemberNowRect = CGRectMake(0, 0, 100, 30);
        latestTeamMemberNow = [[UILabel alloc] initWithFrame:latestTeamMemberNowRect];
        latestTeamMemberNow.textColor = [UIColor colorWithRed:113/255.0f green:113/255.0f blue:113/255.0f alpha:1.0];
        [latestTeamMemberNow setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:latestTeamMemberNow];
        [latestTeamMemberNow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (185);
            make.centerX.equalTo (self);
        }];
        
        //button
        CGRect buttonRect = CGRectMake(0, 0, 120, 50);
        allTeamButton = [[UIButton alloc] initWithFrame:buttonRect];
        [allTeamButton.layer setMasksToBounds:YES];
        //[allInfoButton.layer setCornerRadius:10.0];//圆角
        [allTeamButton.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 30/255.0f, 195/255.0f, 153/255.0f, 1 });
        [allTeamButton.layer setBorderColor:colorref];
        [allTeamButton setTitle:@" 查看全部 " forState:UIControlStateNormal];
        [allTeamButton setTitleColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0] forState:UIControlStateNormal];
        //allInfoButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [self addSubview:allTeamButton];
        [allTeamButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (220);
            make.centerX.equalTo (self);
        }];
        
        //line
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0]];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (269);
            make.bottom.equalTo (self.mas_top).offset (270);
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
