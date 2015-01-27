//
//  TJCommentRequestModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJCommentRequestModel : JSONModel

//@property (nonatomic,assign)int user_id;  //评论用户ID  user_id
//@property (nonatomic,assign)int project_id;  //评论项目ID  project_id
//@property (nonatomic,copy)NSString *content;  //评论内容  content
@property (nonatomic,assign)int userId;  //评论用户ID  user_id
@property (nonatomic,assign)int projectId;  //评论项目ID  project_id
@property (nonatomic,copy)NSString *commentText;  //评论内容  content

@end
