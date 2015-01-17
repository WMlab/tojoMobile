//
//  TJProjectSender.h
//  TojoMobile
//
//  Created by sdq on 15/1/8.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJSender.h"
#import "TJProjectListViewModel.h"

typedef void (^ProjectCommonCallBack)(BOOL success, NSString *message);


@interface TJProjectSender : TJSender

+(instancetype) getInstance;

-(void) sendGetProjectListWithViewModel:(TJProjectListViewModel *)viewModel completeBlock:(ProjectCommonCallBack)callback;

@end