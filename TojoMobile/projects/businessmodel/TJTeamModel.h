//
//  TJTeamModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@protocol  TJTeamModel

@end

@interface TJTeamModel : JSONModel

@property (nonatomic,copy)NSString *teamId;
@property (nonatomic,copy)NSString *projectId;
@property (nonatomic,copy)NSString *teamFounderId;
@property (nonatomic,copy)NSString *teamName;
@property (nonatomic,copy)NSString *teamFounderName;
@property (nonatomic,copy)NSString *teamFounderImage;
@property (nonatomic,copy)NSString *teamFounderSchool;
@property (nonatomic,copy)NSString *teamCreatedDate;
@property (nonatomic,assign)int teamMemberAll;
@property (nonatomic,assign)int teamMemberNow;
@property (nonatomic,copy)NSString *teamDeadlineDate;
@property (nonatomic,copy)NSString *teamDescription;

@end
