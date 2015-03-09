//
//  TJProjectSender.h
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJSender.h"
#import "TJProjectListViewModel.h"
#import "TJProjectDetailViewModel.h"
#import "TJCommentListViewModel.h"
#import "TJTeamListViewModel.h"
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
#import "TJProjectHomeViewModel.h"

typedef void (^ProjectCommonCallBack)(BOOL success, NSString *message);


@interface TJProjectSender : TJSender

+(instancetype) getInstance;
/*
 *  获取项目列表
 */
-(void) sendGetProjectListWithViewModel:(TJProjectListViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback;

-(void) sendGetProjectDetailWithViewModel:(TJProjectDetailViewModel *)viewModel projectId:(int)projectId completeBlock:(ProjectCommonCallBack)callback;

-(void) sendGetCommentListWithViewModel:(TJCommentListViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback;

-(void) sendGetTeamListWithViewModel:(TJTeamListViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback;

-(void) postCommentWithCommentRequestModel:(TJCommentRequestModel *)requestModel completeBlock:(ProjectCommonCallBack)callback;
/*
 *  获取项目主页数据
 */
-(void) sendGetProjectHomeDataWithViewModel:(TJProjectHomeViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback;


@end
