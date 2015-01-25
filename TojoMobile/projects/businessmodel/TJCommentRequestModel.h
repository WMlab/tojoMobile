//
//  TJCommentRequestModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJCommentRequestModel : JSONModel

@property (nonatomic,assign)int userId;  //评论用户ID
@property (nonatomic,assign)int projectId;  //评论项目ID
@property (nonatomic,copy)NSString *commentText;  //评论内容

@end
