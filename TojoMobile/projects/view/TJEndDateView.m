//
//  EndDateView.m
//  TojoMobile
//
//  Created by sdq on 15/1/16.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJEndDateView.h"

@implementation TJEndDateView

@synthesize endDateLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor blackColor]];
        
        CGRect baoMingJieZhiRiQiRect = CGRectMake(8, 4, 70, 9);
        UILabel *baoMingJieZhiRiQi = [[UILabel alloc] initWithFrame:baoMingJieZhiRiQiRect];
        [baoMingJieZhiRiQi setText:@"报名截止日期"];
        baoMingJieZhiRiQi.textColor = [UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0];
        [baoMingJieZhiRiQi setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        [self addSubview:baoMingJieZhiRiQi];
        
        CGRect endDateLabelRect = CGRectMake(8, 8, 90, 28);
        endDateLabel = [[UILabel alloc] initWithFrame:endDateLabelRect];
        endDateLabel.textColor = [UIColor whiteColor];
        [endDateLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        //endDateLabel.lineBreakMode = UILineBreakModeWordWrap;
        //endDateLabel.numberOfLines = 0;
        [self addSubview:endDateLabel];
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
