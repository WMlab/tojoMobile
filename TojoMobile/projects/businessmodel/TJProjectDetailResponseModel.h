//
//  TJProjectDetailResultBusinessModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"
#import "TJProjectInfoModel.h"
#import "TJCommentModel.h"
#import "TJTeamModel.h"
#import "TJResultModel.h"

@interface TJProjectDetailResponseModel : JSONModel

@property(nonatomic, strong) TJResultModel *result;

/**项目详情**/
@property (nonatomic,copy) TJProjectInfoModel *info;

/**最近评论**/
@property (nonatomic,copy)TJCommentModel<Optional> *comment;

/**最近团队**/
@property (nonatomic,copy)TJTeamModel<Optional> *team;

@end
