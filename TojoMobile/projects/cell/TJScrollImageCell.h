//
//  TJScrollImageCell.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJScrollImageDelegate <NSObject>

- (void) selectPageNumber:(NSInteger) index;

@end


@interface TJScrollImageCell : UITableViewCell

-(void) setCellWithAdProjects:(NSArray *)projectArr;
@property (nonatomic, weak) id<TJScrollImageDelegate> delegate;

@end
