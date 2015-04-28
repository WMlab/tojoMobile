//
//  TJTextFIeld.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTextFIeld.h"
#import "TJDefine.h"

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

-(void) setTextFieldStyle:(TEXTFIELD_TYPE) type {
    if (type == TEXTFIELD_TYPE_LOGIN) {
        
    }
    else if (type == TEXTFIELD_TYPE_REVISE_PASSWORD) {
        self.borderStyle = UITextBorderStyleNone;
        self.layer.borderColor = TJColorHex(0x9e9e9f).CGColor;
        self.layer.cornerRadius = 22;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
    }
}

@end
