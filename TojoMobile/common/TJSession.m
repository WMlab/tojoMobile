//
//  TJSession.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/15.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJSession.h"


static TJSession *_instance = nil;

@interface TJSession ()
@property(nonatomic,strong)TJUserBasicInfoModel * userInfoModel;

@end

@implementation TJSession

-(void)setupUserId:(int)userId {
    [self getUserInfoModel].userId = userId;
}

-(int)getUserId {
    return [self getUserInfoModel].userId;
}

-(TJUserBasicInfoModel *)getUserInfoModel {
    if (!_userInfoModel) {
        _userInfoModel = [[TJUserBasicInfoModel alloc] init];
    }
    return _userInfoModel;
}

@end
