//
//  TJUserLoginResponseModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/6.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJUserLoginResponseModel : JSONModel

@property (nonatomic, assign) int userId;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, assign) short gender;

@end
