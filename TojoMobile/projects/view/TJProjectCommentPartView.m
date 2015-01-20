//
//  ProjectCommentPartView.m
//  TojoMobile
//
//  Created by sdq on 15/1/16.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectCommentPartView.h"
#import <Masonry/Masonry.h>

@implementation TJProjectCommentPartView

@synthesize commentCount;
@synthesize latestCommentUserImg;
@synthesize latestCommentUserName;
@synthesize latestCommentDate;
@synthesize latestCommentText;
@synthesize allCommentButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1.0]];
        
        //comment count
        CGRect commentCountRect = CGRectMake(0, 0, 100, 30);
        commentCount = [[UILabel alloc] initWithFrame:commentCountRect];
        commentCount.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [commentCount setFont:[UIFont boldSystemFontOfSize:20]];
        [self addSubview:commentCount];
        [commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (20);
            make.centerX.equalTo (self);
        }];
        
        //comment user image
        latestCommentUserImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [latestCommentUserImg.layer setMasksToBounds:YES];
        [latestCommentUserImg.layer setCornerRadius:30];
        [self addSubview:latestCommentUserImg];
        [latestCommentUserImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (55);
            make.bottom.equalTo(self.mas_top).offset(115);
            make.left.equalTo(self.mas_left).offset([UIScreen mainScreen].bounds.size.width/2-30);
            make.right.equalTo(self.mas_right).offset(-[UIScreen mainScreen].bounds.size.width/2+30);
            make.centerX.equalTo (self);
        }];
        
        //comment user name
        CGRect latestCommentUserNameRect = CGRectMake(0, 0, 100, 30);
        latestCommentUserName = [[UILabel alloc] initWithFrame:latestCommentUserNameRect];
        latestCommentUserName.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [latestCommentUserName setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:latestCommentUserName];
        [latestCommentUserName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (125);
            make.centerX.equalTo (self);
        }];
        
        //comment date
        CGRect latestCommentDateRect = CGRectMake(0, 0, 100, 30);
        latestCommentDate = [[UILabel alloc] initWithFrame:latestCommentDateRect];
        latestCommentDate.textColor = [UIColor colorWithRed:113/255.0f green:113/255.0f blue:113/255.0f alpha:1.0];
        [latestCommentDate setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:latestCommentDate];
        [latestCommentDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (145);
            make.centerX.equalTo (self);
        }];
        
        //comment content
        CGRect latestCommentTextRect = CGRectMake(0, 0, 100, 30);
        latestCommentText = [[UILabel alloc] initWithFrame:latestCommentTextRect];
        latestCommentText.textColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0];
        [latestCommentText setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [self addSubview:latestCommentText];
        latestCommentText.lineBreakMode = UILineBreakModeWordWrap;
        latestCommentText.numberOfLines = 3;
        [latestCommentText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo (self.mas_top).offset (170);
            make.centerX.equalTo (self);
        }];
        
        //button
        allCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allCommentButton.layer setMasksToBounds:YES];
        //[allInfoButton.layer setCornerRadius:10.0];//圆角
        [allCommentButton.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 30/255.0f, 195/255.0f, 153/255.0f, 1 });
        [allCommentButton.layer setBorderColor:colorref];
        [allCommentButton setTitle:@" 查看全部 " forState:UIControlStateNormal];
        [allCommentButton setTitleColor:[UIColor colorWithRed:30/255.0f green:195/255.0f blue:153/255.0f alpha:1.0] forState:UIControlStateNormal];
        //allInfoButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [self addSubview:allCommentButton];
        [allCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (240);
            make.centerX.equalTo (self);
        }];
        
        //line
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0]];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset (289);
            make.bottom.equalTo (self.mas_top).offset (290);
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
