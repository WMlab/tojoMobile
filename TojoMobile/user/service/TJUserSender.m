//
//  TJUserSender.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/6.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserSender.h"
#import <AFNetworking.h>
#import "TJUserLoginRequestModel.h"
#import "TJUserLoginResponseModel.h"
#import "TJResultModel.h"
#import "TJUserRegisterRequestModel.h"
#import "TJRegisterResponseModel.h"
#import "TJSession.h"
#import "TJUserHomepageRequestModel.h"
#import "TJUserHomepageResponseModel.h"
#import "TJRevisePasswordRequestModel.h"
#import "TJRevisePasswordResponseModel.h"
#import <EaseMob.h>
#import "TJDefine.h"

static TJUserSender* _sender = nil;
@implementation TJUserSender

+(instancetype) getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sender = [[TJUserSender alloc] init];
    });
    return _sender;
}


#pragma mark - 用户登录
-(void) sendUserLoginWithEmail:(NSString *)email password:(NSString *) password completeBlock:(UserCommonCallBack) callBack{
    TJUserLoginRequestModel *requestModel = [[TJUserLoginRequestModel alloc] init];
    requestModel.email = email;
    requestModel.password = password;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_LOGIN];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJUserLoginResponseModel *responseModel = [[TJUserLoginResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            [[TJSession getInstance] setupUserInfoModel:responseModel.userInfo];
            //登陆环信
            NSString *hxUsername = [[TJSession getInstance] getUserInfoModel].hxUsername;
            NSString *hxPassword = [[TJSession getInstance] getUserInfoModel].hxPassword;
            hxUsername = @"test";
            hxPassword = @"111111";
            BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
            if (hxUsername && hxPassword && hxUsername.length > 0 && hxPassword.length > 0 && !isAutoLogin) {
                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:hxUsername
                                                                    password:hxPassword
                                                                  completion:
                 ^(NSDictionary *loginInfo, EMError *error) {
                     if (loginInfo && !error) {
                         //获取群组列表
                         [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
                         
                         //设置是否自动登录
//                         [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                         
                         //将2.1.0版本旧版的coredata数据导入新的数据库
                         EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
                         if (!error) {
                             error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                         }
                         
                         //发送自动登陆状态通知
                         [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_hx_LoginChanged object:@YES];
                         
                     }
                     else
                     {
                         switch (error.errorCode)
                         {
                             case EMErrorServerNotReachable:
                                 break;
                             case EMErrorServerAuthenticationFailure:
                                 break;
                             case EMErrorServerTimeout:
                                 break;
                             default:
                                 break;
                         }
                     }
                 } onQueue:nil];
            }
            //登陆环信 end
            if (callBack) {
                callBack(true, responseModel.result.message);
            }
        }
        else {
            callBack(false, responseModel.result.message);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callBack) {
            callBack(NO, @"登录失败");
        }
    }];
    [reqOperation start];
}

#pragma mark - 用户注册
-(void) sendRegisterPostWithEmail:(NSString *)email password:(NSString *) password completeBlock:(UserCommonCallBack) callBack {
    TJUserRegisterRequestModel *model = [[TJUserRegisterRequestModel alloc] init];
    model.email = email;
    model.password = password;
    NSDictionary *postDic = [self convertToDictionryFromModel:model];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",BASE_URL,REQUEST_URL_REGISTRATION] parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJRegisterResponseModel *responseModel = [[TJRegisterResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            [[TJSession getInstance] setupUserId:responseModel.userId];
            callBack(true, responseModel.result.message);
        }
        else {
            if (callBack) {
                callBack(false, responseModel.result.message);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callBack) {
            callBack(false, @"注册失败");
        }
    }];
}

#pragma mark - 个人主页
-(void) sendGetUserDetailInfoWithViewModel:(TJUserHomepageViewModel *)viewModel completeBlock:(UserCommonCallBack) callBack {
    TJUserHomepageRequestModel *requestModel = [[TJUserHomepageRequestModel alloc] init];
    requestModel.userId = viewModel.userBasicInfo.userId;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_USER_HOMEPAGE];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJUserHomepageResponseModel *responseModel = [[TJUserHomepageResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            viewModel.userBasicInfo = [responseModel.userBasicInfo copy];
            viewModel.userProjectList = [responseModel.userProjectList mutableCopy];
            viewModel.userLabelArr = [responseModel.userLabelArr mutableCopy];
            viewModel.projectCount = responseModel.projectCount;
            viewModel.userLabelCount = responseModel.userLabelCount;
            
            if (callBack) {
                callBack(true, responseModel.result.message);
            }
        }
        else {
            callBack(false, responseModel.result.message);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callBack) {
            callBack(NO, @"网络错误");
        }
    }];
    [reqOperation start];
}

#pragma mark - 修改密码
- (void)sendRevisePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)pwdOld andNewPassword:(NSString *)pwdNew completeBlock:(UserCommonCallBack)callBack {
    TJRevisePasswordRequestModel *requestModel = [[TJRevisePasswordRequestModel alloc] init];
    requestModel.userId = [[TJSession getInstance] getUserId];
    requestModel.passwordNew = pwdNew;
    requestModel.passwordOld = pwdOld;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_REVISE_PASSWORD];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJRevisePasswordResponseModel *responseModel = [[TJRevisePasswordResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            if (callBack) {
                callBack(true, responseModel.result.message);
            }
        }
        else {
            callBack(false, responseModel.result.message);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callBack) {
            callBack(NO, @"网络错误");
        }
    }];
    [reqOperation start];

}

#pragma mark --------- 用户项目列表请求 ----------
-(void) sendGetUserProjectListWithViewModel:(TJUserAttendProjectListViewModel *)viewModel withUserId:(NSString *)userId completeBlock:(UserCommonCallBack)callback{
    TJUserAttendProjectListRequestModel *requestModel = [[TJUserAttendProjectListRequestModel alloc] init];
    requestModel.userId = userId;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_USER_PROJECT_LIST];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJUserAttendProjectListResponseModel *responseModel = [[TJUserAttendProjectListResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && responseModel.count == responseModel.projectList.count && !err) {
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            for (int i=0; i<[responseModel.projectList count]; i++) {
                id item = [responseModel.projectList objectAtIndex:i];
                if ([item isKindOfClass:[TJProjectInfoModel class]]) {
                    [itemArr addObject:item];
                }
            }
            viewModel.userProjectList = itemArr;
            viewModel.projectCount = responseModel.count;
            if (callback) {
                callback(true, responseModel.result.message);
            }
        }
        else {
            if (callback) {
                callback(false, responseModel.result.message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(false, @"网络错误");
        }
    }];
    [reqOperation start];
}

#pragma mark --------- 用户团队列表 -----------
-(void) sendGetUserTeamListWithViewModel:(TJUserAttendTeamListViewModel *)viewModel withUserId:(NSString *)userId completeBlock:(UserCommonCallBack)callback{
    TJUserAttendTeamListRequestModel *requestModel = [[TJUserAttendTeamListRequestModel alloc] init];
    requestModel.userId = userId;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_USER_TEAM_LIST];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJUserAttendTeamListResponseModel *responseModel = [[TJUserAttendTeamListResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            //处理
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            for (int i=0; i<responseModel.count; i++) {
                id item = [responseModel.teamList objectAtIndex:i];
                if ([item isKindOfClass:[TJTeamModel class]]) {
                    [itemArr addObject:item];
                }
            }
            viewModel.userTeamList = itemArr;
            viewModel.teamCount = responseModel.count;
            if (callback) {
                callback(true, responseModel.result.message);
            }
        }
        else {
            if (callback) {
                callback(false, responseModel.result.message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(false, @"网络错误");
        }
    }];
    [reqOperation start];
}



@end
