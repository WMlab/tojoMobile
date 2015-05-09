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
            //创建projectlist table
            const char *createSql="create table if not exists projectlist (id integer primary key autoincrement, projectId integer, projectName text, projectImage text, projectCreatedDate text, projectEndDate text, projectFounderId integer, projectFounderName text, projectFounderImage text, projectFounderUniversityId integer, projectFounderUniversityName text, projectLabel text, projectText text, teamNumber integer, commentNumber integer)";
            if (sqlite3_exec(db, createSql, nil, nil, nil) == SQLITE_OK) {
                NSLog(@"projectlist table create OK");
            }
            else{
                NSLog(@"projectlist table create Fail");
            }
            //创建projectCategory table
            const char *createSql2 = "create table if not exists projectCategory (id integer primary key autoincrement,categoryId integer, customId integer, projectId integer, projectType integer)";//projectType 0-普通，1-广告位
            if (sqlite3_exec(db, createSql2, nil, nil, nil) == SQLITE_OK) {
                NSLog(@"projectCategory table create OK");
            }
            else{
                NSLog(@"projectCategory table create Fail");
            }
            //end
            NSLog(@"database initOK");
            sqlite3_close(db);
        }
        else {
            NSLog(@"database initFail");
        }
    }
}

-(TJProjectHomeViewModel *)getProjectHomeDataWithViewModel:(TJProjectHomeViewModel *)viewModel
{
    NSString * sql1 = @"SELECT projectId, projectName, projectImage, projectCreatedDate, projectEndDate, projectFounderId, projectFounderName, projectFounderImage, projectFounderUniversityId, projectFounderUniversityName, teamNumber, commentNumber, projectLabel FROM projectlist WHERE projectId in (SELECT projectId FROM projectCategory where categoryId = ? and customId = ? and projectType = 0) ";
    NSString * sql2 = @"SELECT projectId, projectName, projectImage, projectCreatedDate, projectEndDate, projectFounderId, projectFounderName, projectFounderImage, projectFounderUniversityId, projectFounderUniversityName, teamNumber, commentNumber, projectLabel FROM projectlist WHERE projectId in (SELECT projectId FROM projectCategory where categoryId = ? and customId = ? and projectType = 1) ";

    NSString * databasePath = TJPathForDocumentsResource(@"database.db");
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr isExecutableFileAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db)==SQLITE_OK) {
            sqlite3_stmt *stmt1, *stmt2;
            if (sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &stmt1, nil) == SQLITE_OK) {
                sqlite3_bind_text(stmt1, 1, [[NSString stringWithFormat:@"%d", viewModel.categoryId] UTF8String], -1, NULL);
                sqlite3_bind_text(stmt1, 2, [[NSString stringWithFormat:@"%d", viewModel.customId] UTF8String], -1, NULL);
            }
            if (sqlite3_prepare_v2(db, [sql2 UTF8String], -1, &stmt2, nil) == SQLITE_OK) {
                sqlite3_bind_text(stmt2, 1, [[NSString stringWithFormat:@"%d", viewModel.categoryId] UTF8String], -1, NULL);
                sqlite3_bind_text(stmt2, 2, [[NSString stringWithFormat:@"%d", viewModel.customId] UTF8String], -1, NULL);
            }
            
            viewModel.projectList = [self getProjectArrayWithSql:stmt1];
            viewModel.adProjects = [self getProjectArrayWithSql:stmt2];
            sqlite3_finalize(stmt1);
            sqlite3_finalize(stmt2);
            sqlite3_close(db);
        }
    }
    return viewModel;
}

- (NSMutableArray *) getProjectArrayWithSql:(sqlite3_stmt *) stmt {
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    while(sqlite3_step(stmt) == SQLITE_ROW) {
        char *projectId = (char *)sqlite3_column_text(stmt, 0);
        NSString *projectIdStr = [[NSString alloc] initWithUTF8String:projectId];
        char *projectName = (char *)sqlite3_column_text(stmt, 1);
        NSString *projectNameStr = [[NSString alloc] initWithUTF8String:projectName];
        char *projectImage = (char *)sqlite3_column_text(stmt, 2);
        NSString *projectImageStr = [[NSString alloc] initWithUTF8String:projectImage];
        char *projectCreatedDate = (char *)sqlite3_column_text(stmt, 3);
        NSString *projectCreatedDateStr = [[NSString alloc] initWithUTF8String:projectCreatedDate];
        char *projectEndDate = (char *)sqlite3_column_text(stmt, 4);
        NSString *projectEndDateStr = [[NSString alloc] initWithUTF8String:projectEndDate];
        char *projectFounderId = (char *)sqlite3_column_text(stmt, 5);
        NSString *projectFounderIdStr = [[NSString alloc] initWithUTF8String:projectFounderId];
        char *projectFounderName = (char *)sqlite3_column_text(stmt, 6);
        NSString *projectFounderNameStr = [[NSString alloc] initWithUTF8String:projectFounderName];
        char *projectFounderImage = (char *)sqlite3_column_text(stmt, 7);
        NSString *projectFounderImageStr = [[NSString alloc] initWithUTF8String:projectFounderImage];
        int projectFounderUniversityId = sqlite3_column_int(stmt, 8);
        char *projectFounderUniversityName = (char *)sqlite3_column_text(stmt, 9);
        NSString *projectFounderUniversityNameStr = [[NSString alloc] initWithUTF8String:projectFounderUniversityName];
        int teamNumber = sqlite3_column_int(stmt, 10);
        int commentNumber = sqlite3_column_int(stmt, 11);
        char *projectLabel = (char *)sqlite3_column_text(stmt, 12);
        NSString *projectLabelStr = [[NSString alloc] initWithUTF8String:projectLabel];
        
        TJProjectInfoModel *model = [[TJProjectInfoModel alloc] init];
        model.projectId = projectIdStr;
        model.projectName = projectNameStr;
        model.projectImage = projectImageStr;
        model.projectCreatedDate = projectCreatedDateStr;
        model.projectEndDate = projectEndDateStr;
        model.projectFounderId = projectFounderIdStr;
        model.projectFounderName = projectFounderNameStr;
        model.projectFounderImage = projectFounderImageStr;
        model.projectFounderUniversityId = projectFounderUniversityId;
        model.projectFounderUniversityName = projectFounderUniversityNameStr;
        model.teamNumber = teamNumber;
        model.commentNumber = commentNumber;
        model.projectLabel = projectLabelStr;
        [resultArr addObject:model];
    }
    return resultArr;
}

-(BOOL)insertProjectWithModel:(TJProjectHomeViewModel *)viewModel {
    NSMutableArray *projectAllArr = [[NSMutableArray alloc] initWithArray:viewModel.adProjects];
    [projectAllArr addObjectsFromArray:viewModel.projectList];
    
    NSString *sql1 = @"insert into projectlist (projectId, projectName, projectImage, projectCreatedDate, projectEndDate, projectFounderId, projectFounderName, projectFounderImage, projectFounderUniversityId, projectFounderUniversityName, teamNumber, commentNumber, projectLabel) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
    NSString *sql2 = @"INSERT INTO projectCategory (categoryId, customId, projectId, projectType) values (?,?,?,?)";
    NSString * databasePath = TJPathForDocumentsResource(@"database.db");
    
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr isExecutableFileAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db)==SQLITE_OK) {
            //表projectlist的插入
            const char *insertSql1=[sql1 UTF8String];
            for (TJProjectInfoModel *cell in projectAllArr) {
                sqlite3_stmt *stmt;
                if(sqlite3_prepare_v2(db, insertSql1, -1, &stmt, NULL) == SQLITE_OK) {
                    sqlite3_bind_text(stmt, 1, [cell.projectId UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 2, [cell.projectName UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 3, [cell.projectImage UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 4, [cell.projectCreatedDate UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 5, [cell.projectEndDate UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 6, [cell.projectFounderId UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 7, [cell.projectFounderName UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 8, [cell.projectFounderImage UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 9, cell.projectFounderUniversityId);
                    sqlite3_bind_text(stmt, 10, [cell.projectFounderUniversityName UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 11, cell.teamNumber);
                    sqlite3_bind_int(stmt, 12, cell.commentNumber);
                    sqlite3_bind_text(stmt, 13, [cell.projectLabel UTF8String], -1, NULL);
                }
                if (sqlite3_step(stmt) == SQLITE_DONE) {
                }else{
                    NSLog(@"insert data Fail");
                }
                sqlite3_finalize(stmt);
            }
            //表projectCategory的插入
            const char *insertSql2=[sql2 UTF8String];
            for (TJProjectInfoModel *model in viewModel.projectList) {
                sqlite3_stmt *stmt;
                if(sqlite3_prepare_v2(db, insertSql2, -1, &stmt, NULL) == SQLITE_OK) {
                    sqlite3_bind_int(stmt, 1, viewModel.categoryId);
                    sqlite3_bind_int(stmt, 2, viewModel.customId);
                    sqlite3_bind_text(stmt, 3, [model.projectId UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 4, 0);
                }
                if (sqlite3_step(stmt) == SQLITE_DONE) {
                }else{
                    NSLog(@"insert data Fail");
                }
                sqlite3_finalize(stmt);
            }
            for (TJProjectInfoModel *model in viewModel.adProjects) {
                sqlite3_stmt *stmt;
                if(sqlite3_prepare_v2(db, insertSql2, -1, &stmt, NULL) == SQLITE_OK) {
                    sqlite3_bind_int(stmt, 1, viewModel.categoryId);
                    sqlite3_bind_int(stmt, 2, viewModel.customId);
                    sqlite3_bind_text(stmt, 3, [model.projectId UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 4, 1);
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

-(BOOL)clearProjectsWithViewModel:(TJProjectHomeViewModel *)viewModel {
    NSString *sql1 = @"DELETE FROM projectlist WHERE projectId IN (select projectId from projectCategory WHERE categoryId = ? AND customId = ? )";
    NSString *sql2 = @"DELETE FROM projectCategory WHERE categoryId = ? AND customId = ?";
    
    NSString * databasePath = TJPathForDocumentsResource(@"database.db");
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr isExecutableFileAtPath:databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db)==SQLITE_OK) {
            //删除表projectlist
            const char *deleteSql1=[sql1 UTF8String];
            sqlite3_stmt *stmt1;
            if(sqlite3_prepare_v2(db, deleteSql1, -1, &stmt1, NULL) == SQLITE_OK) {
                sqlite3_bind_int(stmt1, 1, viewModel.categoryId);
                sqlite3_bind_int(stmt1, 2, viewModel.customId);
            }
            if (sqlite3_step(stmt1) == SQLITE_DONE) {
            }else{
                NSLog(@"delete data Fail");
            }
            sqlite3_finalize(stmt1);
            //删除表projectCategory
            const char *deleteSql2=[sql2 UTF8String];
            sqlite3_stmt *stmt2;
            if(sqlite3_prepare_v2(db, deleteSql2, -1, &stmt2, NULL) == SQLITE_OK) {
                sqlite3_bind_int(stmt2, 1, viewModel.categoryId);
                sqlite3_bind_int(stmt2, 2, viewModel.customId);
            }
            if (sqlite3_step(stmt2) == SQLITE_DONE) {
            }else{
                NSLog(@"delete data Fail");
            }
            sqlite3_finalize(stmt2);

            sqlite3_close(db);
        }else {
            NSLog(@"database initFail");
        }
    }
    return YES;
}

@end
