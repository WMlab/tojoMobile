//
//  TJProjectDetailSender.m
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectSender.h"
#import "TJProjectListResponseModel.h"
#import "TJProjectListRequestModel.h"
#import "TJProjectDetailResponseModel.h"
#import "TJProjectDetailRequestModel.h"
#import "TJProjectInfoModel.h"
#import "TJCommentModel.h"
#import "TJTeamModel.h"
#import <AFNetworking.h>

static TJProjectSender * _sender = nil;

@implementation TJProjectSender

+(instancetype) getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sender = [[TJProjectSender alloc] init];
    });
    return _sender;
}

#pragma mark --------- 项目列表请求 -----------—
-(void) sendGetProjectListWithViewModel:(TJProjectListViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback {
    TJProjectListRequestModel *requestModel = [[TJProjectListRequestModel alloc] init];
//    requestModel.categoryId = viewModel.categoryId;
    requestModel.categoryId = 0;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_PROJECT_LIST];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJProjectListResponseModel *responseModel = [[TJProjectListResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && responseModel.count == responseModel.projectList.count && !err) {
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            for (int i=0; i<[responseModel.projectList count]; i++) {
                id item = [responseModel.projectList objectAtIndex:i];
                if ([item isKindOfClass:[TJProjectInfoModel class]]) {
                    [itemArr addObject:item];
                }
            }
            viewModel.projectList = itemArr;
            viewModel.categoryId = responseModel.categoryId;
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

#pragma mark --------- 项目详情请求 -----------——
-(void) sendGetProjectDetailWithViewModel:(TJProjectDetailViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback{
    TJProjectDetailRequestModel *requestModel = [[TJProjectDetailRequestModel alloc] init];
    requestModel.projectId = 1;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_PROJECT_DETAIL];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJProjectDetailResponseModel *responseModel = [[TJProjectDetailResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            //处理
            //viewModel.commentCount = responseModel.commentCount;
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
