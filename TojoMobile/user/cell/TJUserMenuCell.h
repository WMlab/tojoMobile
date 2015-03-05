//
//  TJUserMenuCell.h
//  TojoMobile
//
//  Created by sdq on 15/3/5.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJUserMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

- (void)setCellWithItemText:(NSString *)text;

@end
