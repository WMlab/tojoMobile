//
//  TJRevisePasswordRequestModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/4/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJRevisePasswordRequestModel : JSONModel

@property (nonatomic, assign) int userId;

@property (nonatomic, strong) NSString *passwordNew;

@property (nonatomic, strong) NSString *passwordOld;

@end
