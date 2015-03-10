//
//  TJScrollPage.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJScrollPage : NSObject

-(id)init;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIColor *titleBackgroundColor;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end
