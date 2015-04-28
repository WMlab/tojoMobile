//
//  TJUserAttendProjectListViewModel.h
//  TojoMobile
//
//  Created by sdq on 15/4/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJUserAttendProjectListViewModel : NSObject

@property(nonatomic, assign) int projectCount;  //用户参与的项目数量
@property(nonatomic, strong) NSArray *userProjectList;  // model - TJProjectInfoModel

@end
