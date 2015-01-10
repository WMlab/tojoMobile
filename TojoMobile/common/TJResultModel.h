//
//  TJResultModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface TJResultModel : JSONModel

@property (nonatomic, assign) short code;
@property (nonatomic, copy) NSString *message;

@end
