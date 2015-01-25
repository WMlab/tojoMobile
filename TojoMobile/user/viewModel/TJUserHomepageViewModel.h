//
//  TJUserHomepageViewModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJProjectInfoModel.h"
#import "TJTeamModel.h"
#import "TJUserBasicInfoModel.h"

@interface TJUserHomepageViewModel : NSObject

@property(nonatomic, strong) TJUserBasicInfoModel *userBasicInfo;//用户基本信息

@property(nonatomic, assign) int projectCount;  //用户参与的项目数量
@property(nonatomic, strong) NSArray<TJProjectInfoModel> *userProjectList;  // model - TJProjectInfoModel

@property(nonatomic, assign) int teamCount;   //用户参与的团队数量
@property(nonatomic, strong) NSArray<TJTeamModel> *userTeamList;  // model - TJTeamModel

@end
