//
//  TJImageScrollView.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/3/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJScrollPage.h"

@interface TJImageScrollView : UIScrollView <UIScrollViewDelegate>

-(int)currentPage;
-(void)animateToPageAtIndex:(int)index;
-(void)addTJScrollPage:(TJScrollPage *)page;
-(void)setupViewsWithArray:(NSArray *)array;

@end
