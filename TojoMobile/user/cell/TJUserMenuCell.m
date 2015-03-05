//
//  TJUserMenuCell.m
//  TojoMobile
//
//  Created by sdq on 15/3/5.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserMenuCell.h"

@implementation TJUserMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithItemText:(NSString *)text{
    [self.itemLabel setText:text];
}

@end
