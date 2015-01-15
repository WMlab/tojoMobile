//
//  TJProjectListViewModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/15.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJProjectListViewModel : NSObject

@property(nonatomic, assign) int categoryId;        //项目类别

@property(nonatomic, strong) NSArray *projectList;  //model - TJProjectInfoModel

@end
