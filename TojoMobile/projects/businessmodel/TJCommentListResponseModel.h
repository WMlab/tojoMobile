//
//  TJCommentListResponseModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "TJCommentModel.h"
#import "TJResultModel.h"

@interface TJCommentListResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

@property(nonatomic, assign) int count;
@property(nonatomic, strong) NSArray<TJCommentModel> *commentList;  // model - TJCommentModel

@end
