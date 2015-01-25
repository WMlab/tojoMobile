//
//  TJUserRegisterRequestModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJUserRegisterRequestModel : JSONModel

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

@end
