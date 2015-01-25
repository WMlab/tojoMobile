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

@property (nonatomic,assign)int teamId;
@property (nonatomic,assign)int teamFounderId;
@property (nonatomic,copy)NSString *teamName;
@property (nonatomic,copy)NSString *teamFounderName;
@property (nonatomic,copy)NSString *teamFounderImage;
@property (nonatomic,copy)NSString *teamFounderSchool;
@property (nonatomic,copy)NSString *teamCreatedDate;
@property (nonatomic,assign)int teamMemberAll;
@property (nonatomic,assign)int teamMemberNow;

@end
