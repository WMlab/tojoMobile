//
//  TJCommentListViewModel.h
//  TojoMobile
//
//  Created by sdq on 15/1/22.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJCommentListViewModel : NSObject

@property(nonatomic, copy) NSString *projectId;        //项目编号
@property(nonatomic, strong) NSArray *commentList;  //model - TJCommentModel

@end
