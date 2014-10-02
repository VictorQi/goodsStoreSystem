//
//  databaseHandler.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-17.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "databaseHandler.h"
#define DB_NAME @"MyDatabase.db"


@implementation databaseHandler

+ (FMDatabase *) creatDB
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:@"/tmp/tmp.db"];
    NSLog(@"Is This Database Thread Safe?%@",[FMDatabase isSQLiteThreadSafe]?@"YES":@"NO");
    {
        if ([db executeQuery:@"select * from table"] == nil)
            NSLog(@"Failed");
        NSLog(@"%d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    return db;
}

- (BOOL)initDatabase
{
    BOOL success;
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
    success = [fm fileExistsAtPath:writableDBPath];
    
    if(!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:DB_NAME];
        NSLog(@"defaultDBPath%@--",defaultDBPath);
        success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!success){
            NSLog(@"error initDatabase: %@", [error localizedDescription]);
        }
        success = YES;
    }
    
    NSLog(@"db-path: %@",writableDBPath);
    
    if(success){
        database = [FMDatabase databaseWithPath:writableDBPath] ;
        if ([database open]) {
            [database setShouldCacheStatements:YES];
        }else{
            NSLog(@"Failed to open database.");
            success = NO;
        }
    }
    
    return success;
}

+ (void) removeOldDB
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:@"/Document/MyDatabase.db" error:nil];
}

- (FMDatabase *) getDB
{
    if ([self initDatabase]) {
        return database;
    }else
        return nil;
}

- (NSString *) SQL:(NSString *)sql inTable:(NSString *)table
{
    return [NSString stringWithFormat:sql, table];
    
}

- (id)init{
    if((self = [super init]))
    {
        database = [[databaseHandler alloc] getDB];
    }
    
    return self;
}

/*
 关闭数据库
 */
- (void)closeDatabase
{
    [database close];
}


@end
