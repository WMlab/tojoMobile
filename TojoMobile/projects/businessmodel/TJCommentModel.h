//
//  TJCommentModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
@protocol  TJCommentModel

@end

@interface TJCommentModel : JSONModel

@property (nonatomic,copy)NSString *commentUserId;
@property (nonatomic,copy)NSString *commentUserName;
@property (nonatomic,copy)NSString *commentUserImage;
@property (nonatomic,copy)NSString *commentText;
@property (nonatomic,copy)NSString *commentDate;

@end
