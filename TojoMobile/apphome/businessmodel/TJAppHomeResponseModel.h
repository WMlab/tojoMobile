//
//  TJAppHomeResponseModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"
#import "TJProjectInfoModel.h"

@interface TJAppHomeResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;
@property(nonatomic, strong) NSArray<TJProjectInfoModel> *adList;
@property(nonatomic, strong) NSArray<TJProjectInfoModel> *selectedList;
@property(nonatomic, strong) NSArray<TJProjectInfoModel> *hottestList;
@property(nonatomic, strong) NSArray<TJProjectInfoModel> *latestList;


@end
