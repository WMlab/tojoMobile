//
//  TJUserAttendRequestModel.h
//  TojoMobile
//
//  Created by sdq on 15/5/4.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJUserAttendRequestModel : JSONModel

@property (nonatomic, copy)NSString * userId;  //用户ID  user_id
@property (nonatomic, copy)NSString * projectId;  //参与项目ID  project_id

@end
