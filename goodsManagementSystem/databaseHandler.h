//
//  databaseHandler.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-17.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@interface databaseHandler : NSObject
{
    FMDatabase *database;
}

+ (FMDatabase *) creatDB;   //creat database
+ (void) removeOldDB;       //remove old database from app's storage
- (FMDatabase *) getDB;     //get info from db
- (NSString *) SQL:(NSString *)sql inTable:(NSString *)table;

@end
