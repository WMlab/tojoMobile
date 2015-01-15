//
//  TJProjectListViewModel.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/15.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectListViewModel.h"

@implementation TJProjectListViewModel

-(instancetype) init{
    self = [super init];
    if (self) {
        _categoryId = 0;
        _projectList = [[NSArray alloc] init];
    }
    return self;
}
@end
