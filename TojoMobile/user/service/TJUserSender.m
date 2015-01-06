//
//  TJUserSender.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/6.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserSender.h"
#import "TJSystemParam.h"
#import <AFNetworking.h>
#import "TJUserLoginRequestModel.h"
#import "TJUserLoginResponseModel.h"

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
    NSMutableURLRequest *urlRequest = [self createRequestWithDataModel:requestModel url:REQUEST_URL_LOGIN];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        BOOL result = [[responseDic objectForKey:@"result"] boolValue];
        NSString *msg = [responseDic objectForKey:@"message"];
        if (1 == result) {
            NSDictionary *infoModel = [responseDic objectForKey:@"user"];
            TJUserLoginResponseModel *responseModel = [[TJUserLoginResponseModel alloc] initWithDictionary:infoModel error:nil];
            NSLog(@"user:%@", responseModel.realName);
            if (callBack) {
                callBack(result, msg);
            }
        }
        else {
            callBack(result, msg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callBack) {
            callBack(NO, @"登录失败");
        }
    }];
    [reqOperation start];
}

- (NSMutableURLRequest *) createRequestWithDataModel:(JSONModel *)model url:(NSString *) url
{
    NSString *postJson = [model toJSONString];
    NSData *data = [postJson dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:REQUEST_TIMEOUT_INTERVAL];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
//    NSString *urlString = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json";
    [request setURL:[NSURL URLWithString:urlString]];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    return request;
}

@end
