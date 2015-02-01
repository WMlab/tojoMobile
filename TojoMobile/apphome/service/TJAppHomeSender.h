//
//  TJAppHomeSender.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJSender.h"
#import "TJAppHomeViewModel.h"

typedef void (^AppHomeCommonCallBack)(BOOL success, NSString *message);

@interface TJAppHomeSender : TJSender
/*
 *  获取单例对象
 */
+(instancetype) getInstance;

/*
 *  获取首页数据
 */
-(void) sendGetAppHomeDataWithViewModel:(TJAppHomeViewModel *)viewModel andUserId:(int)userId completeBlock:(AppHomeCommonCallBack)callback;
@end
