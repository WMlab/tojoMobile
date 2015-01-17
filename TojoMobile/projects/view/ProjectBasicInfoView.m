//
//  ProjectBasicInfoView.m
//  TojoMobile
//
//  Created by sdq on 15/1/16.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "ProjectBasicInfoView.h"
#import <Masonry/Masonry.h>

@implementation ProjectBasicInfoView

@synthesize projectTitleLabel;
@synthesize projectReleasedDateLabel;
@synthesize projectFounderImg;
@synthesize projectFounderLabel;
@synthesize projectFounderUniversityLabel;
@synthesize contactFounderButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        CGRect endDateLabelRect = CGRectMake(0, 0, 100, 30);
        projectTitleLabel = [[UILabel alloc] initWithFrame:endDateLabelRect];
        projectTitleLabel.textColor = [UIColor blackColor];
        [projectTitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [self addSubview:projectTitleLabel];
        [projectTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (20);
            make.centerX.equalTo (self);
        }];
        
        //click
        [contactFounderButton addTarget:self action:@selector(contactFounderButtonClicked)forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)contactFounderButtonClicked{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
