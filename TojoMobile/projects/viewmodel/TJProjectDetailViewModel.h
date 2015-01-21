//
//  TJProjectDetailViewModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJProjectInfoModel.h"
#import "TJCommentModel.h"
#import "TJTeamModel.h"

@interface TJProjectDetailViewModel : NSObject

/**项目详情**/
@property (nonatomic,copy) TJProjectInfoModel *projectInfoModel;

/**评论**/
@property (nonatomic,copy)TJCommentModel *commentModel;


/**团队**/
@property (nonatomic,copy)TJTeamModel *teamModel;

@end
