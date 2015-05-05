//
//  TJUserAttendRequestModel.h
//  TojoMobile
//
//  Created by sdq on 15/5/4.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJUserAttendRequestModel : JSONModel

@property (nonatomic,assign)int userId;  //用户ID  user_id
@property (nonatomic,assign)int projectId;  //参与项目ID  project_id

@end
