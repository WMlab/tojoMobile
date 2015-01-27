//
//  TJTextFIeld.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTextFIeld.h"

@implementation TJTextFIeld

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGRect) textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super editingRectForBounds:bounds];
    return CGRectInset(textRect, 10, 0);
}

-(CGRect) editingRectForBounds:(CGRect)bounds {
    CGRect editRect = [super editingRectForBounds:bounds];
    return CGRectInset(editRect, 10, 0);
}

-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15;
    return iconRect;
}

@end
