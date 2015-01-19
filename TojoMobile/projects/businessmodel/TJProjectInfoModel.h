//
//  TJProjectInfoModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
@protocol  TJProjectInfoModel


@end

@interface TJProjectInfoModel : JSONModel

<<<<<<< HEAD
@property (nonatomic,assign)int projectID;
@property (nonatomic,copy)NSString *projectName;
@property (nonatomic,copy)NSString *projectImage;
@property (nonatomic,copy)NSString *projectCreatDate;
@property (nonatomic,copy)NSString *projectEndDate;
@property (nonatomic,assign)int projectFounderId;
@property (nonatomic,copy)NSString *projectFounderName;
@property (nonatomic,copy)NSString *projectFounderImage;
@property (nonatomic,assign)int projectFounderUniversityId;
@property (nonatomic,copy)NSString *projectFounderUniversityName;
@property (nonatomic,copy)NSString *projectLabel;
@property (nonatomic,copy)NSString *projectText;

=======
@property (nonatomic,assign) int projectID;
@property (nonatomic,copy) NSString *projectName;
@property (nonatomic,copy) NSString *projectImage;
@property (nonatomic,copy) NSString *projectCreatDate;
@property (nonatomic,copy) NSString *projectEndDate;
@property (nonatomic,assign) int projectFounderId;
@property (nonatomic,copy) NSString *projectFounderName;
@property (nonatomic,copy) NSString *projectFounderImage;
@property (nonatomic,assign) int projectFounderUniversityId;
@property (nonatomic,copy) NSString *projectFounderUniversityName;
@property (nonatomic,copy) NSString *projectLabel;
@property (nonatomic,copy) NSString *projectText;
@property (nonatomic,assign) int teamNumber;
>>>>>>> FETCH_HEAD
@end
