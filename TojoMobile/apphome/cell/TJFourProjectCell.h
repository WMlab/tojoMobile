//
//  TJFourProjectCell.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/28.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJProjectInfoModel.h"

@protocol TJFourProjectDelegate <NSObject>

- (void) selectProjectWithModel:(TJProjectInfoModel *)model;

@end

@interface TJFourProjectCell : UITableViewCell

-(void) setCellWithProjects:(NSArray *)projectArr;

@property (nonatomic, strong) NSArray *projectArr;
@property (nonatomic, weak) id<TJFourProjectDelegate> delegate;

@end
