//
//  TJTableHeaderView.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/29.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJTableHeaderView : UIView

@property (nonatomic, strong) NSString *projectTypeStr;

- (id) initWithProjectTypeName:(NSString *) typeName;
@end
