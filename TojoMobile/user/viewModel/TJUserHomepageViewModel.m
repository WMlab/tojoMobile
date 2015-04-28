//
//  TJUserHomepageViewModel.m
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserHomepageViewModel.h"

@implementation TJUserHomepageViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _userBasicInfo = [[TJUserBasicInfoModel alloc] init];
        _projectCount = 0;
    }
    return self;
}

@end
