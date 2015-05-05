//
//  TJUserAttendResponseModel.h
//  TojoMobile
//
//  Created by sdq on 15/5/4.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"

@interface TJUserAttendResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

@end
