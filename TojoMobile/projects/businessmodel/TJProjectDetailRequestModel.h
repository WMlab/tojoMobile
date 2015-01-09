//
//  TJProjectDetailBusinessModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJProjectDetailResponseModel.h"

@interface TJProjectDetailRequestModel : JSONModel

@property (nonatomic,strong) TJProjectDetailResponseModel *result;

@end
