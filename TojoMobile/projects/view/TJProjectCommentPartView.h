//
//  ProjectCommentPartView.h
//  TojoMobile
//
//  Created by sdq on 15/1/16.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJProjectCommentPartView : UIView

@property (strong, nonatomic) UILabel *commentCount;
@property (strong, nonatomic) UIImageView *latestCommentUserImg;
@property (strong, nonatomic) UILabel *latestCommentUserName;
@property (strong, nonatomic) UILabel *latestCommentDate;
@property (strong, nonatomic) UILabel *latestCommentText;
@property (strong, nonatomic) UIButton *allCommentButton;

@end
