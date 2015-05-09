//
//  TJTeamListViewModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/20.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJTeamListViewModel : NSObject

@property(nonatomic, copy) NSString * projectId;        //项目编号
@property(nonatomic, strong) NSArray *teamList;  //model - TJTeamModel

@end
