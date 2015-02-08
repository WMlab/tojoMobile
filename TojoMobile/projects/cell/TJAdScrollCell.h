//
//  TJAdScrollCell.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMScrollPage.h"
#import "MMScrollPresenter.h"
#import "TJProjectInfoModel.h"

@protocol TJAdScrollDelegate <NSObject>

- (void) selectProjectWithModel:(TJProjectInfoModel *)model;

@end

@interface TJAdScrollCell : UITableViewCell

-(void) setCellWithAdProjects:(NSArray *)projectArr;

@property (nonatomic, strong) NSArray *projectArr;
@property (nonatomic, weak) id<TJAdScrollDelegate> delegate;

@end
