//
//  TJProjectHomeResponseModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/3.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"
#import "TJProjectInfoModel.h"

@interface TJProjectHomeResponseModel : JSONModel

@property (nonatomic, strong) TJResultModel *result;

@property (nonatomic, assign) int categoryId;
@property (nonatomic, assign) int customId;

@property (nonatomic, strong) NSMutableArray<TJProjectInfoModel> *adProjects;
@property (nonatomic, strong) NSMutableArray<TJProjectInfoModel> *projectList;
@end
