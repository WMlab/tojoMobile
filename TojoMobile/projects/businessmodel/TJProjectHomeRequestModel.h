//
//  TJProjectHomeRequestModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/3.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJProjectHomeRequestModel : JSONModel

@property (nonatomic, assign) int userId;

@property (nonatomic, assign) int categoryId;//项目按标签分类, 0表示不分类

@property (nonatomic, assign) int customId;//自定义的分类，推荐=1,最新=2,最热=3,同校=4

@end
