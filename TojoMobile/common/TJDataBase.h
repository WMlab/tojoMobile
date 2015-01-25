//
//  TJDataBase.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/11.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJDataBase : NSObject

+(instancetype)getInstance;

-(void)initDatabase;

/*** 获取缓存 ***/
-(NSArray *)getProjectsWithCategoryId:(int)categoryId;

/*** 添加缓存 ***/
-(BOOL)insertProjectWithMutableArray:(NSArray *)array andCategoryId:(int)categoryId;

/*** 删除原有缓存 ***/
-(BOOL)clearNewsWithCategoryId:(int)categoryId;
@end
