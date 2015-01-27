//
//  TJSession.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/15.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJUserBasicInfoModel.h"

@interface TJSession : NSObject

+(instancetype)getInstance;

/**
 *设置userModel
 */
-(BOOL)setupUserInfoModel:(TJUserBasicInfoModel *)model;

/**
 *获取userModel
 */
-(TJUserBasicInfoModel *)getUserInfoModel;

/**
 *退出登录
 */
-(void)clearUserInfoModel;

/**
 *设置用户ID
 */
-(void)setupUserID:(int)userID;

/**
 *获得用户ID
 */
-(int)getUserID;


@end
