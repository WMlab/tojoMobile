//
//  TJProjectDetailSender.m
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectSender.h"
#import "TJProjectHomeRequestModel.h"
#import "TJProjectHomeResponseModel.h"
#import "TJProjectListResponseModel.h"
#import "TJProjectListRequestModel.h"
#import "TJProjectDetailResponseModel.h"
#import "TJProjectDetailRequestModel.h"
#import "TJCommentListRequestModel.h"
#import "TJCommentListResponseModel.h"
#import "TJTeamListRequestModel.h"
#import "TJTeamListResponseModel.h"
#import "TJTeamDetailRequestModel.h"
#import "TJTeamDetailResponseModel.h"

static TJProjectSender * _sender = nil;

@implementation TJProjectSender

+(instancetype) getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sender = [[TJProjectSender alloc] init];
    });
    return _sender;
}
#pragma mark --------- 项目主页数据请求 ----------
-(void) sendGetProjectHomeDataWithViewModel:(TJProjectHomeViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback {
    
    TJProjectHomeRequestModel *requestModel = [[TJProjectHomeRequestModel alloc] init];
    requestModel.categoryId = viewModel.categoryId;
    requestModel.customId = viewModel.customId;
    requestModel.userId = 1;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_PROJECT_HOME];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //先清除原有缓存数据
        [viewModel.adProjects removeAllObjects];
        [viewModel.projectList removeAllObjects];

        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJProjectHomeResponseModel *responseModel = [[TJProjectHomeResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            viewModel.categoryId = responseModel.categoryId;
            viewModel.customId = responseModel.customId;
            
            viewModel.adProjects = responseModel.adProjects;
            viewModel.projectList = responseModel.projectList;
    
            if (callback) {
                callback(true, responseModel.result.message);
            }
        }
        else {
            //先清除原有缓存数据
            [viewModel.adProjects removeAllObjects];
            [viewModel.projectList removeAllObjects];

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

#pragma mark --------- 用户项目列表请求 ----------
-(void) sendGetUserProjectListWithViewModel:(TJUserAttendProjectListViewModel *)viewModel withUserId:(int)userId completeBlock:(ProjectCommonCallBack)callback{
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

#pragma mark --------- 项目详情请求 -----------
-(void) sendGetProjectDetailWithViewModel:(TJProjectDetailViewModel *)viewModel projectId:(int)projectId completeBlock:(ProjectCommonCallBack)callback{
    TJProjectDetailRequestModel *requestModel = [[TJProjectDetailRequestModel alloc] init];
    requestModel.projectId = projectId;
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
-(void) sendGetCommentListWithViewModel:(TJCommentListViewModel *)viewModel projectId:(int)projectId completeBlock:(ProjectCommonCallBack)callback{
    TJCommentListRequestModel *requestModel = [[TJCommentListRequestModel alloc] init];
    requestModel.projectId = projectId;
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
-(void) sendGetTeamListWithViewModel:(TJTeamListViewModel *)viewModel  projectId:(int)projectId completeBlock:(ProjectCommonCallBack)callback{
    TJTeamListRequestModel *requestModel = [[TJTeamListRequestModel alloc] init];
    requestModel.projectId = projectId;
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

#pragma mark --------- 用户团队列表 -----------
-(void) sendGetUserTeamListWithViewModel:(TJUserAttendTeamListViewModel *)viewModel withUserId:(int)userId completeBlock:(ProjectCommonCallBack)callback{
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

#pragma mark --------- 团队详情 -----------
-(void) sendGetTeamDetailWithViewModel:(TJTeamDetailViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback {
    TJTeamDetailRequestModel *requestModel = [[TJTeamDetailRequestModel alloc] init];
    requestModel.teamId = viewModel.team.teamId;
    NSMutableURLRequest *urlRequest = [self createRequestWithMethod:REQUEST_METHOD_GET DataModel:requestModel url:REQUEST_URL_PROJECT_TEAM_DETAIL];
    AFHTTPRequestOperation *reqOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    reqOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [reqOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJTeamDetailResponseModel *responseModel = [[TJTeamDetailResponseModel alloc] initWithDictionary:responseDic error:&err];
        if (0 == responseModel.result.code && !err) {
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            for (int i=0; i<[responseModel.teamMemberList count]; i++) {
                id item = [responseModel.teamMemberList objectAtIndex:i];
                if ([item isKindOfClass:[TJUserBasicInfoModel class]]) {
                    [itemArr addObject:item];
                }
            }
            viewModel.team = responseModel.team;
            viewModel.teamMemberList = itemArr;
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
-(void) postCommentWithCommentRequestModel:(TJCommentRequestModel *)requestModel completeBlock:(ProjectCommonCallBack)callback{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = [self convertToDictionryFromModel:requestModel];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@", BASE_URL, REQUEST_URL_PROJECT_COMMENT_LIST] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
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
        NSLog(@"failed");
    }];
}

#pragma mark --------- 个人参加项目 -----------
-(void) postUserAttendProjectRequestModel:(TJUserAttendRequestModel *)requestModel completeBlock: (ProjectCommonCallBack)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = [self convertToDictionryFromModel:requestModel];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@", BASE_URL, REQUEST_URL_USER_PROJECT_LIST] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSError *err;
        TJUserAttendResponseModel *responseModel = [[TJUserAttendResponseModel alloc] initWithDictionary:responseDic error:&err];
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
        NSLog(@"failed");
    }];

}

@end
