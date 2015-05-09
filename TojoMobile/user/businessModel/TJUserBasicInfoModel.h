//
//  TJUserBasicInfoModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@protocol TJUserBasicInfoModel

@end

@interface TJUserBasicInfoModel : JSONModel

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userEmail;
@property (nonatomic, copy) NSString *userRealName;
@property (nonatomic, assign) int userGender;
@property (nonatomic, copy) NSString *userUniversity;
@property (nonatomic, copy) NSString *userImage;
@property (nonatomic, copy) NSString <Optional> *hxUsername;
@property (nonatomic, copy) NSString <Optional> *hxPassword;

@end
