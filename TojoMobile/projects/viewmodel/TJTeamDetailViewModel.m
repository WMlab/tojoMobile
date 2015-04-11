//
//  TJTeamDetailViewModel.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTeamDetailViewModel.h"

@implementation TJTeamDetailViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _team = [[TJTeamModel alloc] init];
        _teamMemberList = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
