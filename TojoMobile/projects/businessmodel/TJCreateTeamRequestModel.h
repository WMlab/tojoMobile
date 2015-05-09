//
//  TJCreateTeamRequestModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJCreateTeamRequestModel : JSONModel

@property (nonatomic,copy) NSString *teamFounderId;  //创建人ID
@property (nonatomic,copy) NSString *projectId;  //项目ID
@property (nonatomic,copy) NSString *teamName;  //团队名字
@property (nonatomic,assign) int teamMemberAll;  //团队总人数
@property (nonatomic,copy) NSString *teamEndDate; //报名截止日期
@property (nonatomic,copy) NSString *teamDescription; //团队简介

@end
