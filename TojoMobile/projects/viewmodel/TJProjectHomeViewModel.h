//
//  TJProjectHomeViewModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/3.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJProjectHomeViewModel : NSObject

@property (nonatomic, assign) int categoryId;
@property (nonatomic, assign) int customId;

@property (nonatomic, strong) NSMutableArray *adProjects; // model - TJProjectInfoModel
@property (nonatomic, strong) NSMutableArray *projectList;// model - TJProjectInfoModel


@end
