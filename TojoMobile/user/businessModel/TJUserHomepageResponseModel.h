//
//  TJUserHomepageResponseModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"
#import "TJProjectInfoModel.h"
//#import "TJTeamModel.h"
#import "TJUserBasicInfoModel.h"
#import "TJUserLabelModel.h"

@interface TJUserHomepageResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

@property(nonatomic, strong) TJUserBasicInfoModel *userBasicInfo;//用户基本信息

@property(nonatomic, assign) int projectCount;  //用户参与的项目数量
@property(nonatomic, strong) NSMutableArray<TJProjectInfoModel, Optional> *userProjectList;  // model - TJProjectInfoModel

@property(nonatomic, assign) int userLabelCount; //用户标签数量
@property(nonatomic, strong) NSMutableArray<TJUserLabelModel, Optional> *userLabelArr;

//@property(nonatomic, assign) int teamCount;   //用户参与的团队数量
//@property(nonatomic, strong) NSArray<TJTeamModel, Optional> *userTeamList;  // model - TJTeamModel

@end
