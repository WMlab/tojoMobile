//
//  TJTeamDetailViewModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJTeamModel.h"

@interface TJTeamDetailViewModel : NSObject

@property (nonatomic,strong) TJTeamModel *team;
@property (nonatomic, strong) NSMutableArray *teamMemberList;  // model - TJUserBasicInfoModel

@end
