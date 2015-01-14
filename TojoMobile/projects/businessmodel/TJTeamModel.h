//
//  TJTeamModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJTeamModel : NSObject

@property (nonatomic,assign)int TeamFounderId;
@property (nonatomic,copy)NSString *TeamName;
@property (nonatomic,copy)NSString *TeamFounderName;
@property (nonatomic,copy)NSString *TeamFounderImage;
@property (nonatomic,copy)NSString *TeamFounderSchool;
@property (nonatomic,copy)NSString *TeamCreatedDate;
@property (nonatomic,assign)int TeamMemberAll;
@property (nonatomic,assign)int TeamMemberNow;

@end
