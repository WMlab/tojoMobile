//
//  TJRegisterResponseModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"

@interface TJRegisterResponseModel : JSONModel
@property (nonatomic, strong) TJResultModel *result;

@property (nonatomic, copy) NSString *userId;

@end