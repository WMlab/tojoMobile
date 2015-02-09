//
//  TJTableHeaderView.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/29.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJTableHeaderView.h"
#import "TJDefine.h"

@implementation TJTableHeaderView

- (id) initWithProjectTypeName:(NSString *) typeName {
    self = [super initWithFrame:CGRectMake(0, 0, TJScreenWidth, 33)];
    if (self) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 6, 40, 20)];
        typeLabel.text = typeName;
        typeLabel.textColor = TJColorHex(0x1ec399);
        [self addSubview:typeLabel];
        
        UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(TJScreenWidth - 45, 6, 40, 20)];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:TJColorHex(0x1ec399) forState:UIControlStateNormal];
        [self addSubview:moreBtn];
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
