//
//  TJAppHomeSender.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJAppHomeSender.h"
#import "TJAppHomeRequestModel.h"
#import "TJAppHomeResponseModel.h"
static TJAppHomeSender *_sender = nil;

@implementation TJAppHomeSender

+(instancetype) getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sender = [[TJAppHomeSender alloc] init];
    });
    return _sender;
}

-(void) sendGetAppHomeDataWithViewModel:(TJAppHomeViewModel *)viewModel andUserId:(int)userId completeBlock:(AppHomeCommonCallBack)callback {
    TJAppHomeRequestModel *requestModel = [[TJAppHomeRequestModel alloc] init];
    requestModel.userId = userId;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_APP_HOME];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJAppHomeResponseModel *responseModel = [[TJAppHomeResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            viewModel.adProjectList = responseModel.adList;
            viewModel.selectedProjectList = responseModel.selectedList;
            viewModel.hottestProjectList = responseModel.hottestList;
            viewModel.latestProjectList = responseModel.latestList;
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
