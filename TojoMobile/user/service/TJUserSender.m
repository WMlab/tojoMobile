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
            [[TJSession getInstance] setupUserId:responseModel.userId];
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
            viewModel.userProjectList = [responseModel.userProjectList copy];
            viewModel.userTeamList = [responseModel.userTeamList copy];
            
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
//- (NSMutableURLRequest *) createRequestWithDataModel:(JSONModel *)model url:(NSString *) url
//{
//    NSString *postJson = [model toJSONString];
//    NSData *data = [postJson dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"POST"];
//    [request setTimeoutInterval:REQUEST_TIMEOUT_INTERVAL];
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:data];
//    return request;
//}

@end
