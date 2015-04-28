//
//  TJTextFIeld.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/26.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TEXTFIELD_TYPE) {
    TEXTFIELD_TYPE_LOGIN = 1,
    TEXTFIELD_TYPE_REFISTER = 2,
    TEXTFIELD_TYPE_REVISE_PASSWORD = 3,
};

@interface TJTextFIeld : UITextField


-(void) setTextFieldStyle:(TEXTFIELD_TYPE) type;

@end
