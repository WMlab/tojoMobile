//
//  TJUserLoginRequestModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/6.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJUserLoginRequestModel : JSONModel

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;

@end
