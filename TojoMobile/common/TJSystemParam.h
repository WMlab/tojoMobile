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

#define TJUserLoginSuccess @"kTJUserLoginSuccess"

//#define BASE_URL @"http://api.tongjo.com/"
#define BASE_URL @"http://api.tongjo.com/"
#define IMAGE_BASE_URL @"http://api.tongjo.com/files/"

#define REQUEST_TIMEOUT_INTERVAL 30

/************** home ***************/
#define REQUEST_URL_APP_HOME           @"apphome"

/************** user ***************/
#define REQUEST_URL_LOGIN                   @"login"            //登陆
#define REQUEST_URL_REGISTRATION            @"registration"     //注册
#define REQUEST_URL_USER_HOMEPAGE           @"homepage"         //他人访问个人主页
#define REQUEST_URL_REVISE_PASSWORD         @"revisepassword"   //修改密码

/************** project ***************/
#define REQUEST_URL_PROJECT_HOME            @"projecthome"      //项目主页
#define REQUEST_URL_PROJECT_LIST            @"projectlist"
#define REQUEST_URL_PROJECT_DETAIL          @"projectdetail"    //项目详情
#define REQUEST_URL_PROJECT_COMMENT_LIST    @"commentlist"
#define REQUEST_URL_PROJECT_TEAM_LIST       @"teamlist"
#define REQUEST_URL_PROJECT_TEAM_BUILD      @"teambuild"
#define REQUEST_URL_PROJECT_TEAM_DETAIL     @"teamdetail"       //团队详情

#endif
