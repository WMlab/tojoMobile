//
//  TJTeamListResponseModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"
#import "TJTeamModel.h"

@interface TJTeamListResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

@property(nonatomic, assign) int count;
@property(nonatomic, strong) NSArray<TJTeamModel> *teamList;  // model - TJTeamModel

@end
