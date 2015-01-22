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
#import "TJProjectInfoModel.h"

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
            const char *createSql="create table if not exists projectlist (id integer primary key autoincrement,categoryId integer, projectID integer, projectName text, projectImage text, projectCreatedDate text, projectEndDate text, projectFounderId integer, projectFounderName text, projectFounderImage text, projectFounderUniversityId integer, projectFounderUniversityName text, projectLabel text, projectText text, teamNumber integer, commentNumber integer)";
            if (sqlite3_exec(db, createSql, nil, nil, nil) == SQLITE_OK) {
                NSLog(@"projectlist table create OK");
            }
            else{
                NSLog(@"projectlist table create Fail");
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
    NSString * sql = @"SELECT projectID, projectName, projectImage, projectCreatedDate, projectEndDate, projectFounderId, projectFounderName, projectFounderImage, projectFounderUniversityId, projectFounderUniversityName, teamNumber, commentNumber FROM projectlist WHERE categoryId = ?";
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
                int projectID = sqlite3_column_int(stmt, 0);
                char *projectName = (char *)sqlite3_column_text(stmt, 1);
                NSString *projectNameStr = [[NSString alloc] initWithUTF8String:projectName];
                char *projectImage = (char *)sqlite3_column_text(stmt, 2);
                NSString *projectImageStr = [[NSString alloc] initWithUTF8String:projectImage];
                char *projectCreatedDate = (char *)sqlite3_column_text(stmt, 3);
                NSString *projectCreatedDateStr = [[NSString alloc] initWithUTF8String:projectCreatedDate];
                char *projectEndDate = (char *)sqlite3_column_text(stmt, 4);
                NSString *projectEndDateStr = [[NSString alloc] initWithUTF8String:projectEndDate];
                int projectFounderId = sqlite3_column_int(stmt, 5);
                char *projectFounderName = (char *)sqlite3_column_text(stmt, 6);
                NSString *projectFounderNameStr = [[NSString alloc] initWithUTF8String:projectFounderName];
                char *projectFounderImage = (char *)sqlite3_column_text(stmt, 7);
                NSString *projectFounderImageStr = [[NSString alloc] initWithUTF8String:projectFounderImage];
                int projectFounderUniversityId = sqlite3_column_int(stmt, 8);
                char *projectFounderUniversityName = (char *)sqlite3_column_text(stmt, 9);
                NSString *projectFounderUniversityNameStr = [[NSString alloc] initWithUTF8String:projectFounderUniversityName];
                int teamNumber = sqlite3_column_int(stmt, 10);
                int commentNumber = sqlite3_column_int(stmt, 11);
                
                TJProjectInfoModel *model = [[TJProjectInfoModel alloc] init];
                model.projectID = projectID;
                model.projectName = projectNameStr;
                model.projectImage = projectImageStr;
                model.projectCreatedDate = projectCreatedDateStr;
                model.projectEndDate = projectEndDateStr;
                model.projectFounderId = projectFounderId;
                model.projectFounderName = projectFounderNameStr;
                model.projectFounderImage = projectFounderImageStr;
                model.projectFounderUniversityId = projectFounderUniversityId;
                model.projectFounderUniversityName = projectFounderUniversityNameStr;
                model.teamNumber = teamNumber;
                model.commentNumber = commentNumber;
                [result addObject:model];
            }
            sqlite3_finalize(stmt);
            sqlite3_close(db);
        }
    }

    return result;
}

-(BOOL)insertProjectWithMutableArray:(NSMutableArray *)array andCategoryId:(int)categoryId {
    NSString * sql = @"insert into projectlist (categoryId, projectID, projectName, projectImage, projectCreatedDate, projectEndDate, projectFounderId, projectFounderName, projectFounderImage, projectFounderUniversityId, projectFounderUniversityName, teamNumber, commentNumber) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
    NSString * databasePath = TJPathForDocumentsResource(@"database.db");
    
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr isExecutableFileAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db)==SQLITE_OK) {
            const char *insertSql=[sql UTF8String];
            for (TJProjectInfoModel *cell in array) {
                sqlite3_stmt *stmt;
                if(sqlite3_prepare_v2(db, insertSql, -1, &stmt, NULL) == SQLITE_OK) {
                    sqlite3_bind_int(stmt, 1, categoryId);;
                    sqlite3_bind_int(stmt, 2, cell.projectID);
                    sqlite3_bind_text(stmt, 3, [cell.projectName UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 4, [cell.projectImage UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 5, [cell.projectCreatedDate UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 6, [cell.projectEndDate UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 7, cell.projectFounderId);
                    sqlite3_bind_text(stmt, 8, [cell.projectFounderName UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 9, [cell.projectFounderImage UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 10, cell.projectFounderUniversityId);
                    sqlite3_bind_text(stmt, 11, [cell.projectFounderUniversityName UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 12, cell.teamNumber);
                    sqlite3_bind_int(stmt, 13, cell.commentNumber);
                }
                if (sqlite3_step(stmt) == SQLITE_DONE) {
                }else{
                    NSLog(@"insert data Fail");
                }
                sqlite3_finalize(stmt);
            }
            sqlite3_close(db);
        }else {
            NSLog(@"database initFail");
        }
    }
    return YES;
}

-(BOOL)clearNewsWithCategoryId:(int)categoryId{
    NSString * sql = @"delete from projectlist where categoryId = ?";
    NSString * databasePath = TJPathForDocumentsResource(@"database.db");
    
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr isExecutableFileAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db)==SQLITE_OK) {
            const char *deleteSql=[sql UTF8String];
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(db, deleteSql, -1, &stmt, NULL) == SQLITE_OK) {
                sqlite3_bind_int(stmt, 1, categoryId);
            }
            if (sqlite3_step(stmt) == SQLITE_DONE) {
            }else{
                NSLog(@"delete data Fail");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(db);
        }else {
            NSLog(@"database initFail");
        }
    }
    return YES;
}

@end
