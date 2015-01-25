//
//  TJTeamDetailResponseModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"
#import "TJTeamModel.h"
#import "TJUserBasicInfoModel.h"

@interface TJTeamDetailResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

@property (nonatomic,copy)TJTeamModel *team;
@property(nonatomic, strong) NSArray<TJUserBasicInfoModel> *teamMemberList;  // model - TJProjectInfoModel


@end
