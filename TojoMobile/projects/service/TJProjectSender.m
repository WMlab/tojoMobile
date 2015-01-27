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
#import "TJCommentListRequestModel.h"
#import "TJCommentListResponseModel.h"
#import "TJTeamListRequestModel.h"
#import "TJTeamListResponseModel.h"
#import "TJCommentRequestModel.h"
#import "TJCommentResponseModel.h"
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

#pragma mark --------- 项目列表请求 ----------
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

#pragma mark --------- 项目详情请求 -----------
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
            viewModel.projectInfoModel = responseModel.info;
            viewModel.commentModel = responseModel.comment;
            viewModel.teamModel = responseModel.team;
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

#pragma mark --------- 评论列表请求 -----------
-(void) sendGetCommentListWithViewModel:(TJCommentListViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback{
    TJCommentListRequestModel *requestModel = [[TJCommentListRequestModel alloc] init];
    requestModel.projectId = 1;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_PROJECT_COMMENT_LIST];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJCommentListResponseModel *responseModel = [[TJCommentListResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            //处理
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            for (int i=0; i<responseModel.count; i++) {
                id item = [responseModel.commentList objectAtIndex:i];
                if ([item isKindOfClass:[TJCommentModel class]]) {
                    [itemArr addObject:item];
                }
            }
            viewModel.commentList = itemArr;
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

#pragma mark --------- 团队列表请求 -----------
-(void) sendGetTeamListWithViewModel:(TJTeamListViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback{
    TJTeamListRequestModel *requestModel = [[TJTeamListRequestModel alloc] init];
    requestModel.projectId = 1;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_PROJECT_TEAM_LIST];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJTeamListResponseModel *responseModel = [[TJTeamListResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            //处理
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            for (int i=0; i<responseModel.count; i++) {
                id item = [responseModel.teamList objectAtIndex:i];
                if ([item isKindOfClass:[TJTeamModel class]]) {
                    [itemArr addObject:item];
                }
            }
            viewModel.teamList = itemArr;
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

#pragma mark --------- 发布评论 -----------
-(void) postComment: (ProjectCommonCallBack)callback{
    TJCommentRequestModel *requestModel = [[TJCommentRequestModel alloc] init];
//    requestModel.project_id = 1;
//    requestModel.user_id = 1;
//    requestModel.content = @"这是一个测试的评论";
    requestModel.projectId = 1;
    requestModel.userId = 1;
    requestModel.commentText = @"这是一个测试的评论";
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_POST DataModel:requestModel url:REQUEST_URL_PROJECT_COMMENT_LIST];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJCommentResponseModel *responseModel = [[TJCommentResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            //处理
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
