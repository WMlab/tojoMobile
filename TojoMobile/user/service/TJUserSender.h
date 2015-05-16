//
//  TJUserSender.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/6.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJUserHomepageViewModel.h"
#import "TJSender.h"
#import "TJUserAttendProjectListViewModel.h"
#import "TJUserAttendProjectListRequestModel.h"
#import "TJUserAttendProjectListResponseModel.h"
#import "TJUserAttendTeamListViewModel.h"
#import "TJUserAttendTeamListRequestModel.h"
#import "TJUserAttendTeamListResponseModel.h"

typedef void (^UserCommonCallBack)(BOOL success, NSString *message);

@interface TJUserSender : TJSender

+(instancetype) getInstance;
/**
 *  func: 发送用户登录请求
 *  params: email - 用户邮箱
 *          password - 密码
 *          callback - 回调
 *  return: void
 */
-(void) sendUserLoginWithEmail:(NSString *)email password:(NSString *) password completeBlock:(UserCommonCallBack) callBack;

/**
 *  用户注册请求
 */
-(void) sendRegisterPostWithEmail:(NSString *)email password:(NSString *) password completeBlock:(UserCommonCallBack) callBack;

/**
 *  获取用户详细信息
 */
-(void) sendGetUserDetailInfoWithViewModel:(TJUserHomepageViewModel *)viewModel completeBlock:(UserCommonCallBack) callBack;

/**
 *  修改账号密码
 */
-(void) sendRevisePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPwd andNewPassword:(NSString *)neewPwd completeBlock:(UserCommonCallBack) callBack;

/**
 *  获取用户参与项目列表
 */
-(void) sendGetUserProjectListWithViewModel:(TJUserAttendProjectListViewModel *)viewModel withUserId:(NSString *)userId completeBlock:(UserCommonCallBack)callback;

/**
 *  获取用户参与团队列表
 */
-(void) sendGetUserTeamListWithViewModel:(TJUserAttendTeamListViewModel *)viewModel withUserId:(NSString *)userId completeBlock:(UserCommonCallBack)callback;

@end
