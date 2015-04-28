//
//  TJUserLabelModel.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/4/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "JSONModel.h"

@protocol TJUserLabelModel

@end

@interface TJUserLabelModel : JSONModel

@property (nonatomic, assign) int labelId;
@property (nonatomic, strong) NSString *labelName;

@end
