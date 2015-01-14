//
//  TJProjectListResponseModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <JSONModel.h>
#import "TJResultModel.h"
#import "TJProjectInfoModel.h"

@interface TJProjectListResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

@property(nonatomic, assign) int categoryId;        //项目类别
@property(nonatomic, assign) int count;
@property(nonatomic, strong) NSArray *projectList;  // model - TJProjectInfoModel

@end
