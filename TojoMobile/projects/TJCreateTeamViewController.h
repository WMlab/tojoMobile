//
//  TJCreateTeamViewController.h
//  TojoMobile
//
//  Created by sdq on 15/1/25.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJCreateTeamViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *teamName;
@property (weak, nonatomic) IBOutlet UITextField *teamMemberCount;
@property (weak, nonatomic) IBOutlet UITextField *teamEndDate;
@property (weak, nonatomic) IBOutlet UITextField *teamIntroduce;


@end
