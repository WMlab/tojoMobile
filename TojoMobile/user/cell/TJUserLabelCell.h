//
//  TJUserLabelCell.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/4/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJUserLabelCell : UITableViewCell


- (void) setCellWithLabels:(NSMutableArray *)labelArr;

+ (CGFloat) getCellHeightWithLabels:(NSMutableArray *)labelArr;

@end
