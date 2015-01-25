//
//  TJUserRegisterResponseModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"

@interface TJUserRegisterResponseModel : JSONModel

@property (nonatomic, strong) TJResultModel *result;

@property (nonatomic, assign) int userId;

@end
