//
//  TJUserLabelCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/4/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJUserLabelCell.h"
#import "TJUserLabelModel.h"
#import "TJDefine.h"

#define LABEL_HEIGHT 20
@implementation TJUserLabelCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) getCellHeightWithLabels:(NSMutableArray *)labelArr {
    if (labelArr.count == 0) {
        return 40;
    }
    CGFloat x = 15.0, y=10.0;
    for (TJUserLabelModel *userLabel in labelArr) {
        CGRect rect = [userLabel.labelName boundingRectWithSize:CGSizeMake(MAXFLOAT, LABEL_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat width = rect.size.width + 10;
        if (x + width > TJScreenWidth - 15) {
            x = 15;
            y += LABEL_HEIGHT + 5;
        }
        x += width + 10;
    }
    return y + LABEL_HEIGHT + 10;
}

- (void) setCellWithLabels:(NSMutableArray *)labelArr {
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    if (labelArr.count == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TJScreenWidth, self.contentView.bounds.size.height)];
        label.text = @"暂无标签";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label];
        return;
    }
    CGFloat x = 15.0, y=10.0;
    for (TJUserLabelModel *userLabel in labelArr) {
        CGFloat width = [self calLabelWidthForString:userLabel.labelName];
        if (x + width > TJScreenWidth - 15) {
            x = 15;
            y += LABEL_HEIGHT + 5;
        }
        width += 10;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, LABEL_HEIGHT)];
        label.layer.borderColor = [UIColor blueColor].CGColor;
        label.layer.borderWidth = 0.5;
        label.text = userLabel.labelName;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        x += width + 10;
    }
}

- (CGFloat) calLabelWidthForString:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, LABEL_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return rect.size.width;
}

@end
