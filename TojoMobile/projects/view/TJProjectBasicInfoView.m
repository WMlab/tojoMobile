//
//  ProjectBasicInfoView.m
//  TojoMobile
//
//  Created by sdq on 15/1/16.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectBasicInfoView.h"
#import <Masonry/Masonry.h>

@implementation TJProjectBasicInfoView

@synthesize projectTitleLabel;
@synthesize projectReleasedDateLabel;
@synthesize projectFounderImg;
@synthesize projectFounderLabel;
@synthesize projectFounderUniversityLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //project title
        CGRect projectTitleLabelRect = CGRectMake(0, 0, 100, 30);
        projectTitleLabel = [[UILabel alloc] initWithFrame:projectTitleLabelRect];
        projectTitleLabel.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [projectTitleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [self addSubview:projectTitleLabel];
        [projectTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (20);
            make.centerX.equalTo (self);
        }];
        
        //project release date
        CGRect projectReleasedDateLabelRect = CGRectMake(0, 0, 100, 30);
        projectReleasedDateLabel = [[UILabel alloc] initWithFrame:projectReleasedDateLabelRect];
        projectReleasedDateLabel.textColor = [UIColor colorWithRed:113/255.0f green:113/255.0f blue:113/255.0f alpha:1.0];
        [projectReleasedDateLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [self addSubview:projectReleasedDateLabel];
        [projectReleasedDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (45);
            make.centerX.equalTo (self);
        }];
        
        //founder image
        projectFounderImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [projectFounderImg.layer setMasksToBounds:YES];
        [projectFounderImg.layer setCornerRadius:30];
        [self addSubview:projectFounderImg];
        [projectFounderImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (75);
            make.bottom.equalTo(self.mas_top).offset(135);
            make.left.equalTo(self.mas_left).offset([UIScreen mainScreen].bounds.size.width/2-30);
            make.right.equalTo(self.mas_right).offset(-[UIScreen mainScreen].bounds.size.width/2+30);
            make.centerX.equalTo (self);
        }];
        
        //founder name
        CGRect projectFounderLabelRect = CGRectMake(0, 0, 100, 30);
        projectFounderLabel = [[UILabel alloc] initWithFrame:projectFounderLabelRect];
        projectFounderLabel.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [projectFounderLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [self addSubview:projectFounderLabel];
        [projectFounderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (145);
            make.centerX.equalTo (self);
        }];
        
        //founder university
        CGRect projectFounderUniversityLabelRect = CGRectMake(0, 0, 100, 30);
        projectFounderUniversityLabel = [[UILabel alloc] initWithFrame:projectFounderUniversityLabelRect];
        projectFounderUniversityLabel.textColor = [UIColor colorWithRed:113/255.0f green:113/255.0f blue:113/255.0f alpha:1.0];
        [projectFounderUniversityLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [self addSubview:projectFounderUniversityLabel];
        [projectFounderUniversityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (165);
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
