//
//  TJMemberCollectionCell.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/4/11.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJMemberCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *memberImageView;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberSchoolLabel;
@end
