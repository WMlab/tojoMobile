//
//  TJSystemParam.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/6.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#ifndef TojoMobile_TJSystemParam_h
#define TojoMobile_TJSystemParam_h

#define TJScreenWidth ([[UIScreen mainScreen]bounds].size.width)

//#define BASE_URL @"http://api.tongjo.com/"
#define BASE_URL @"http://api.tongjo.com/"
#define IMAGE_BASE_URL @"http://api.tongjo.com/files/"

#define REQUEST_TIMEOUT_INTERVAL 30

/************** user ***************/
#define REQUEST_URL_LOGIN           @"login"
#define REQUEST_URL_REGISTRATION @"registration"

/************** project ***************/
#define REQUEST_URL_PROJECT_LIST    @"projectlist"
#define REQUEST_URL_PROJECT_DETAIL    @"projectdetail"
#define REQUEST_URL_PROJECT_COMMENT_LIST    @"commentlist"
#define REQUEST_URL_PROJECT_COMMENT    @"comment"
#define REQUEST_URL_PROJECT_TEAM_LIST    @"teamlist"

#endif
