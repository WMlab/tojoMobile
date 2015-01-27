//
//  TJUserSender.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/6.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJUserRegisterRequestModel.h"
#import "TJSender.h"

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
-(void) sendRegisterPostWithModel:(TJUserRegisterRequestModel *)model completeBlock:(UserCommonCallBack) callBack;

@end
