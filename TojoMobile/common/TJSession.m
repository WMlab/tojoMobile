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

+(instancetype) getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TJSession alloc] init];
    });
    return _instance;
}

-(void)setupUserId:(NSString *)userId {
    [self getUserInfoModel].userId = userId;
}

-(NSString *)getUserId {
    return [self getUserInfoModel].userId;
}

-(TJUserBasicInfoModel *)getUserInfoModel {
    if (!_userInfoModel) {
        _userInfoModel = [[TJUserBasicInfoModel alloc] init];
    }
    return _userInfoModel;
}

-(BOOL)setupUserInfoModel:(TJUserBasicInfoModel *)model {
    _userInfoModel = model;
    return true;
}

-(void)clearUserInfoModel {
    _userInfoModel = [[TJUserBasicInfoModel alloc]init];
    NSUserDefaults * usrDefault = [NSUserDefaults standardUserDefaults];
    [usrDefault removeObjectForKey:@"usr"];
    [usrDefault removeObjectForKey:@"pwd"];
}
@end
