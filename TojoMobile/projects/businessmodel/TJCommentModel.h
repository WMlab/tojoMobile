//
//  TJCommentModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJCommentModel : NSObject

@property (nonatomic,assign)int CommentUserId;
@property (nonatomic,copy)NSString *CommentUserName;
@property (nonatomic,copy)NSString *ommentUserImage;
@property (nonatomic,copy)NSString *CommentText;
@property (nonatomic,copy)NSString *CommentDate;

@end
