//
//  TJProjectInfoViewController.h
//  TojoMobile
//
//  Created by sdq on 15/1/18.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJProjectInfoModel.h"

@interface TJProjectInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

-(void)setInfoModel:(TJProjectInfoModel *)infoModel;

@end
