//
//  TJDataBase.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/11.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJDataBase.h"
#import "TJFilePath.h"
#import <sqlite3.h>

static TJDataBase *_database = nil;

@implementation TJDataBase
{
    sqlite3 *db;
}

+(instancetype)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _database = [[TJDataBase alloc] init];
    });
    return _database;
}

-(void)initDatabase
{
    NSString * databasePath = TJPathForDocumentsResource(@"database.db");
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr isExecutableFileAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db)==SQLITE_OK) {
            const char *createSql="create table if not exists projectlist (id integer primary key autoincrement,categoryId integer, projectID integer, projectName text, projectImage text, projectCreatDate text, projectEndDate text, projectFounderId integer, projectFounderName text, projectFounderImage text, projectFounderUniversityId integer, projectFounderUniversityName text, projectLabel text, projectText text, teamNumber integer)";
            if (sqlite3_exec(db, createSql, nil, nil, nil) == SQLITE_OK) {
                NSLog(@"news table create OK");
            }
            else{
                NSLog(@"news table create Fail");
            }
            NSLog(@"database initOK");
            sqlite3_close(db);
        }
        else {
            NSLog(@"database initFail");
        }
    }
}

-(NSMutableArray *)getProjectsWithCategoryId:(int)categoryId
{
    NSMutableArray * result = [[NSMutableArray alloc]init];
    NSString * sql = @"SELECT projectID, projectName, projectImage, projectCreatDate, projectEndDate, projectFounderId, projectFounderName, projectFounderImage, projectFounderUniversityId, projectFounderUniversityName FROM projectlist WHERE categoryId = ?";
    NSString * databasePath = TJPathForDocumentsResource(@"database.db");
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr isExecutableFileAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db)==SQLITE_OK) {
            sqlite3_stmt *stmt;
            if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
                sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%d", categoryId] UTF8String], -1, NULL);
            }
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                char *projectID = (char *)sqlite3_column_text(stmt, 0);
                NSString *projectIDStr = [[NSString alloc] initWithUTF8String:projectID];
                char *projectName = (char *)sqlite3_column_text(stmt, 1);
                NSString *projectNameStr = [[NSString alloc] initWithUTF8String:projectName];
                char *newsType = (char *)sqlite3_column_text(stmt, 2);
                NSString *newsTypeStr = [[NSString alloc] initWithUTF8String:newsType];
                char *newsTitle = (char *)sqlite3_column_text(stmt, 3);
                NSString *newsTitleStr = [[NSString alloc] initWithUTF8String:newsTitle];
                char *newsSubTitle = (char *)sqlite3_column_text(stmt, 4);
                NSString *newsSubTitleStr = [[NSString alloc] initWithUTF8String:newsSubTitle];
                char *newsTime = (char *)sqlite3_column_text(stmt, 5);
                NSString *newsTimeStr = [[NSString alloc] initWithUTF8String:newsTime];
                char *newsImageUrl = (char *)sqlite3_column_text(stmt, 6);
                NSString *newsImageUrlStr = [[NSString alloc] initWithUTF8String:newsImageUrl];
//                HYSquareListViewModel * viewModel = [[HYSquareListViewModel alloc] init];
//                viewModel.moduleID = moduleIDStr;
//                viewModel.newsID = newsIDStr;
//                viewModel.newsType = newsTypeStr;
//                viewModel.newsTitle = newsTitleStr;
//                viewModel.fansNumber = newsSubTitleStr;
//                viewModel.newsTime = newsTimeStr;
//                viewModel.newsImageUrl = newsImageUrlStr;
//                [result addObject:viewModel];
            }
            sqlite3_finalize(stmt);
            sqlite3_close(db);
        }
    }

    return result;
}

@end
