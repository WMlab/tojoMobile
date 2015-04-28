//
//  TJUserAttendTeamListResponseModel.h
//  TojoMobile
//
//  Created by sdq on 15/4/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJResultModel.h"
#import "TJTeamModel.h"
#import "JSONModel.h"

@interface TJUserAttendTeamListResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;
@property(nonatomic, assign) int count;
@property(nonatomic, strong) NSArray<TJTeamModel> *teamList;  // model - TJProjectInfoModel

@end
