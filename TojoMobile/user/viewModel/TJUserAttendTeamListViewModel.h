//
//  TJUserAttendTeamListViewModel.h
//  TojoMobile
//
//  Created by sdq on 15/4/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJTeamModel.h"

@interface TJUserAttendTeamListViewModel : NSObject

@property(nonatomic, assign) int teamCount;   //用户参与的团队数量
@property(nonatomic, strong) NSArray *userTeamList;  // model - TJTeamModel

@end
