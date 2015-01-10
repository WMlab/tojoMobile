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
            const char *createSql="create table if not exists news (id integer primary key autoincrement, moduleID text, newsID text, newsType text, newsTitle text, newsSubTitle text, newsTime text, newsImageUrl text)";
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

@end
