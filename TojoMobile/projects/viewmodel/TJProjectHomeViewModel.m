//
//  TJProjectHomeViewModel.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/3.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectHomeViewModel.h"

@implementation TJProjectHomeViewModel

-(instancetype) init{
    self = [super init];
    if (self) {
        _categoryId = 0;
        _customId = 1;
        _projectList = [[NSMutableArray alloc] init];
        _adProjects = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
