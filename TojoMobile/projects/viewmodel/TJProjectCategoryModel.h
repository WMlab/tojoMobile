//
//  TJProjectCategoryModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/1.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@interface TJProjectCategoryModel : JSONModel

@property (nonatomic, assign) int catId;
@property (nonatomic, assign) int labelId;
@property (nonatomic, strong) NSString *catName;

@end
