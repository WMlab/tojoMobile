//
//  TJCommentResponseModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/23.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJResultModel.h"

@interface TJCommentResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

@end
