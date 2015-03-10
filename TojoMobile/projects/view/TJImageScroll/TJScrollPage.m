//
//  TJScrollPage.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJScrollPage.h"

@implementation TJScrollPage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init
{
    self = [super init];
    
    if(self)
    {
        self.titleView = [[UIView alloc] init];
        self.backgroundView = [[UIView alloc] init];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.titleLabel setText:@"Default Title Text"];
        [self.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
        self.titleLabel.numberOfLines = 2;
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.adjustsFontSizeToFitWidth = YES;
        [self.detailLabel setText:@"Default Detail Text"];
        [self.detailLabel setTextColor:[UIColor whiteColor]];
        [self.detailLabel setLineBreakMode:NSLineBreakByWordWrapping];
        self.detailLabel.numberOfLines = 2;
        self.detailLabel.font = [UIFont systemFontOfSize:13];
        
        [self.backgroundView setBackgroundColor:[UIColor lightGrayColor]];
        
        self.titleBackgroundColor = [UIColor blackColor];
    }
    
    return self;
}

@end
