//
//  TJTeamListViewModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJTeamListViewModel : NSObject

@property(nonatomic, assign) int projectId;        //项目类别
@property(nonatomic, strong) NSArray *commentList;  //model - TJCommentModel

@end
