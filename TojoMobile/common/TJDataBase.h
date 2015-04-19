//
//  TJDataBase.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/11.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJProjectHomeViewModel.h"
@interface TJDataBase : NSObject

+(instancetype)getInstance;

-(void)initDatabase;

/*** 获取缓存 ***/
-(TJProjectHomeViewModel *)getProjectHomeDataWithViewModel:(TJProjectHomeViewModel *)viewModel;

/*** 添加缓存 ***/
-(BOOL)insertProjectWithModel:(TJProjectHomeViewModel *)viewModel;

/*** 删除原有缓存 ***/
-(BOOL)clearProjectsWithViewModel:(TJProjectHomeViewModel *)viewModel;
@end
