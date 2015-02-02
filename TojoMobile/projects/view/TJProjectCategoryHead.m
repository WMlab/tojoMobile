//
//  TJProjectCategoryHead.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/2/1.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJProjectCategoryHead.h"
#import "TJDefine.h"

@interface TJProjectCategoryHead ()

@end

@implementation TJProjectCategoryHead

- (id) init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, TJScreenWidth, 30);
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, TJScreenWidth - 30, 30)];
        scrollView.contentSize = CGSizeMake(600 , 30);
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        [btn1 setTitle:@"推荐" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 200, 30)];
        [btn2 setTitle:@"最热" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(400, 0, 200, 30)];
        [btn3 setTitle:@"同校" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [scrollView addSubview:btn1];
        [scrollView addSubview:btn2];
        [scrollView addSubview:btn3];
        
        [self addSubview:scrollView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
