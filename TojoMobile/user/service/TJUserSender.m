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
//    NSMutableURLRequest *urlRequest = [self createRequestWithDataModel:requestModel url:REQUEST_URL_LOGIN];
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_LOGIN];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJUserLoginResponseModel *responseModel = [[TJUserLoginResponseModel alloc] initWithDictionary:responseDic error:&err];
//        NSDictionary *resultDic = [responseDic objectForKey:@"result"];
//        TJResultModel *resultModel = [[TJResultModel alloc] initWithDictionary:resultDic error:nil];
//        NSString *msg = resultModel.message;
        if (0 == responseModel.result.code && !err) {
//            NSDictionary *infoModel = [responseDic objectForKey:@"user"];
//            TJUserLoginResponseModel *responseModel = [[TJUserLoginResponseModel alloc] initWithDictionary:infoModel error:nil];
//            NSLog(@"user:%@", responseModel.realName);
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
