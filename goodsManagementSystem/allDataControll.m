//
//  allDataControll.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-17.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "allDataControll.h"
#import "dbLog.h"
@implementation allDataControll


#define SELL_GOODS @"卖货"
#define BUY_GOODS @"进货"
#define ADD_USER @"注册用户"
#define LOGIN @"登陆"
#define CHANGEWORD @"修改密码"
#define UPDATE @"更新"
#define BUY  @"新建进货单"
#define BUY_TYPE 2
#define SELL @"新建出货单"
#define SELL_TYPE 3
#define PERMISSION_1 @"审核人员"
#define PERMISSION_2 @"销售人员"
#define PERMISSION_3 @"采购人员"

static allDataControll *sharedSingleton = nil; //权限静态实例设置
//单例
+ (allDataControll *)shareSingleton
{
    
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[allDataControll alloc] init];
    }
    return sharedSingleton;
}


- (BOOL) createTable  //创建表
{
    NSString *createGoods = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (Id INTEGER PRIMARY KEY AUTOINCREMENT, goodsName text , Price text , Sell text, Count integer,goodsInfo text, Category text NOT NULL ,UNIQUE (goodsName));",@"GOODS"];  //create GOODS-TABLE
    
    NSString *createSellCount = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (Id INTEGER PRIMARY KEY AUTOINCREMENT, Count integer, goodsName text references %@(goodsName) on delete restrict);",@"SELLCOUNT",@"GOODS"];      //create SELLCOUNT-TABLE
    
    NSString *createUser = [NSString stringWithFormat :@"CREATE TABLE IF NOT EXISTS %@ (Id INTEGER PRIMARY KEY AUTOINCREMENT,Username text NOT NULL, Password text NOT NULL , Category text,UNIQUE (Username));",@"USER"];
    
    NSString *createLog = [NSString stringWithFormat :@"CREATE TABLE IF NOT EXISTS %@ (Time text, Content text,Type text, person text);",@"LOG"];
    
    
    NSString *createSellList = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (Id INTEGER PRIMARY KEY AUTOINCREMENT, goodsName TEXT references %@(goodsName) on delete restrict,Price TEXT,Count INTEGER,Time text,Permission INTEGER);",@"SELLLIST",@"GOODS"];
    
    NSString *createBuyList = [NSString stringWithFormat:@"create table if not exists %@ (Id integer primary key autoincrement,goodsName text not null,Price text,Count integer,goodsInfo TEXT,Category text NOT NULL,Time text,Permission integer);",@"BUYLIST"];
    
    [database executeUpdate:createSellCount];
    [database executeUpdate:createUser];
    [database executeUpdate:createLog];
    [database executeUpdate:createGoods];
    [database executeUpdate:createSellList];
    [database executeUpdate:createBuyList];
    if ([database hadError]) {
        NSLog(@"Err initDatabase %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        return NO;
    }
    return YES;
}

//向user表中插入用户
- (BOOL) insertValueIntoUserTable:(NSString *)username andPSW:(NSString *)password andCategory:(NSString *)category
{
    BOOL success;
    //NSError *err = nil;
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (Username,Password,Category) VALUES(?,?,?)",@"USER"];
    success = [database executeUpdate:sql,username,password,category];
    
    if ([database hadError]) {
        NSLog(@"Error insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        return   NO;
    }
    
    
    NSInteger x_code = -1;
    NSString *sqlForX = [NSString stringWithFormat:@"select Id from %@ where Username = ?",@"USER"];
    FMResultSet *rs = [database executeQuery:sqlForX,username];
    while ([rs next]) {
        x_code = [rs intForColumn:@"Id"];
    }
    if (x_code != -1) {
        success = [self addLog:[NSString stringWithFormat:@"新增一名用户，用户名：%@ ,职位：%@ ,识别码：%ld ",username,category,x_code] type:ADD_USER];
    }else{
        success = NO;}
    
    return success;
}


- (BOOL) insertToBuyList:(NSString *)goodname
                Buyprice:(NSString *)price
                Buycount:(NSInteger)count
                goodInfo:(NSString *)info
            goodCategory:(NSString *)goodcategory
{
    BOOL success;
    NSString *time = [FormatTime getCurrentTime];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (Id,goodsName,Price,Count,goodsInfo,Category,Time,Permission) VALUES (?,?,?,?,?,?,?,?)",@"BUYLIST"];
    success =  [database executeUpdate:sql,[NSNull null],goodname,price,[NSNumber numberWithInteger:count],info,goodcategory,time,[NSNumber numberWithInt:0]];
    if ([database hadError]) {
        NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        success =  NO;
    }
    [self addLog:[NSString stringWithFormat:@"新增了一进货单,名称:%@,价格:%@元,分类:%@,数量:%ld",goodname,price,goodcategory,count] type:BUY];
    return success;
}

- (BOOL) insertToSellList:(NSString *)goodname
                SellPrice:(NSString *)price
                SellCount:(NSInteger)count
{
    BOOL success;
    NSString *time = [FormatTime getCurrentTime];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (Id,goodsName,Price,Count,Time,Permission) VALUES (?,?,?,?,?,?)",@"SELLLIST"];
    success =  [database executeUpdate:sql,[NSNull null],goodname,price,[NSNumber numberWithInteger:count],time,[NSNumber numberWithInt:0]];
    if ([database hadError]) {
        NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        success =  NO;
    }
    [self addLog:[NSString stringWithFormat:@"新增了一出货单,名称:%@,售价:%@元,数量:%ld",goodname,price,count] type:SELL];
    return success;
}




- (BOOL) setPermissionByType:(NSString *)listtype
                   andListId:(NSInteger)listid
                 andListName:(NSString *)name
                    andCount:(NSString *)count
                    andPrice:(NSString *)price
                 andCategoty:(NSString *)category
                     andInfo:(NSString *)info
              withPermission:(NSInteger)permissionallow
{
    BOOL success = NO;
    if ([listtype isEqualToString:@"出货单"]&&permissionallow == 1) {
        NSString *sql = [NSString stringWithFormat:@"update %@ set Permission = ? where Id = ?",@"SELLLIST"];
        [database executeUpdate:sql,[NSNumber numberWithInteger:permissionallow],[NSNumber numberWithInteger:listid]];
        NSString *sql_1 = [NSString stringWithFormat:@"INSERT INTO %@ (Id,Count,goodsName) VALUES (?,?,?)",@"SELLCOUNT"];
        [database executeUpdate:sql_1,[NSNull null],count,name];
        success = [self updateCountValue:name count:count price:price];
    }else if([listtype isEqualToString:@"进货单"]&&permissionallow == 1)
    {
        NSString *sql_2 = [NSString stringWithFormat:@"update %@ set Permission = ? where Id = ?",@"BUYLIST"];
        /*FMResultSet *rs_1 = [database executeQuery:[NSString stringWithFormat:@"select * from %@ where Id = ?",@"BUYLIST"],listid];
        NSString *categoryString = @"";
        NSString *infoString = @"";
        while ([rs_1 next]) {
            categoryString = [rs_1 stringForColumn:@"Category"];
            infoString = [rs_1 stringForColumn:@"goodsInfo"];
        }*/
        [database executeUpdate:sql_2,[NSNumber numberWithInteger:permissionallow],[NSNumber numberWithInteger:listid]];
        BOOL flag_1 = FALSE;   //判断goodsname是否在GOODS表中
        FMResultSet *rs_4 = [database executeQuery:[NSString stringWithFormat:@"select * from %@ where goodsName = ?",@"GOODS"],name];
        if  ([rs_4 next]) {
            flag_1 = TRUE;
            NSString *sql_3 = [NSString stringWithFormat:@"update GOODS set Price = ? ,Count = Count + ? where goodsName = ?"];
            [database executeUpdate:sql_3,price,[NSNumber numberWithInteger:[count integerValue]],name];
            success = [self addLog:[NSString stringWithFormat:@"审批通过：新增商品：%@ 的库存 %@ 件，进价为 %@ 元",name,count,price] type:BUY_GOODS];
        }else{
            success = [self insertValueIntoTableInfo:info andName:name andPrice:price andSell:@"" andCount:[count integerValue] andCategory:category];
        }
    }
    
    return success;
}


//向goods表中插入数据
- (BOOL)insertValueIntoTableInfo:(NSString *)info andName:(NSString *)name andPrice:(NSString *)price andSell:(NSString *)sell andCount:(NSInteger)count andCategory:(NSString *)category
{
    BOOL success ;
    //NSError *err = nil;
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (Id,goodsName,Price,Sell,Count,goodsInfo,Category) VALUES (?,?,?,?,?,?,?)",@"GOODS"];
    [database executeUpdate:sql,[NSNull null],name,price,sell,[NSNumber numberWithInteger:count],info,category];
    
    if ([database hadError]) {
        NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        success = NO;
    }
    
    
    success = [self addLog:[NSString stringWithFormat:@"审批通过：新进入一单货物，商品名：%@ ,单价：%@ 元，进货数目：%ld 件，分类：%@ ",name,price,count,category] type:BUY_GOODS];
    
    return success;
}

- (BOOL) updateCountValue:(NSString *)name
                    count:(NSString *)count
                    price:(NSString *)price    //更新销售数据
{
    BOOL success;
    //NSError *err = nil;
    NSString *sql = [NSString stringWithFormat:@"update %@ set Count  = Count - ? ,Sell = ? where goodsName = ?",@"GOODS"];
    [database executeUpdate:sql,[NSNumber numberWithInt:[count intValue]],price,name];
    
    if ([database hadError]) {
        NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        success =  NO;
    }
    
    
    success = [self addLog:[NSString stringWithFormat:@"销售了一个商品:%@,数量:%@, 价格:%@",name,count,price] type:SELL_GOODS];
    
    
    
    return success;
}

- (NSString *)login:(NSString *)username :(NSString *)password //登陆匹配
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@  where Username =  ?", @"USER"];
    NSString *category = nil;
    FMResultSet *rs = [database executeQuery:sql,username];
    while ([rs next]) {
        if ([rs stringForColumn:@"Password"])
        {
            [self addLog:[NSString stringWithFormat:@"用户名: %@ 成功登陆系统",username] type:LOGIN];
            [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"User"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        category = [rs stringForColumn:@"Category"];;
    }
    [rs close];
    return category;
}


- (BOOL) addLog:(NSString *)content type:(NSString *)type  //每次操作更新日志
{
    NSString *time = [FormatTime getCurrentTime];
    NSString *person = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (Time, Content,Type,person) VALUES (?,?,?,?)",@"LOG"];
    [database executeUpdate:sql,time,[NSString stringWithFormat:@"%@",content],type,person];
    if ([database hadError]) {
        NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        return NO;
    }
    return YES;
}

- (void) deleteValueWithName:(NSString *)name    //从表中删除一种货物
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where goodsName = ?",@"GOODS"];
    [database executeUpdate:sql,name];
}




//更改密码
- (BOOL)changePassword:(NSString *)username newpassword:(NSString *)newpassword uniqueId:(NSInteger)usersid
{
    BOOL permission = NO;
    NSString *sql = [NSString stringWithFormat:@"select *  from %@  where Username =  ?", @"USER"];
    FMResultSet *rs = [database executeQuery:sql,username];
    while ([rs next]) {
        if ([rs intForColumn:@"Id"])
        {
            if ([rs intForColumn:@"Id"] == usersid)
                permission = YES;
        }
    }
    [rs close];
    
    if (permission == YES) {
        NSString *sqlX = [NSString stringWithFormat:@"update %@ set password = ?  where username = ? ", @"USER"];
        [database executeUpdate:sqlX,newpassword,username];
        if ([database hadError]) {
            NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
            return NO;
        }
        [self addLog:[NSString stringWithFormat:@"用户名: %@ ,识别码：%ld ,成功修改密码",username,usersid] type:CHANGEWORD];
        return YES;
    }
    return NO;
}


//关键字查询goods表中相应的数据
- (NSMutableArray *) getKeyGOODSValue:(NSString *)key
{
    NSMutableArray *market = [[NSMutableArray alloc] init];
    if ([key isEqualToString:@""]){
        NSString *sql = [NSString stringWithFormat:@"select * from %@",@"GOODS"];
        FMResultSet *rs = [database executeQuery:sql];
        while ([rs next]) {
            Goods *goods = [[Goods alloc] init];
            goods.goodsId = [rs stringForColumn:@"Id"];
            goods.goodsName = [rs stringForColumn:@"goodsName"];
            goods.goodsInfo = [rs stringForColumn:@"goodsInfo"];
            goods.price = [rs stringForColumn:@"Price"];
            goods.sell = [rs stringForColumn:@"Sell"];
            goods.category = [rs stringForColumn:@"Category"];
            goods.count = [NSString stringWithFormat:@"%d",[rs intForColumn:@"Count"]];
            [market addObject:goods];
        }
    }
    else{
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where goodsName like '%%%@%%' or Id like '%%%@%%'",@"GOODS",key,key];
        FMResultSet *rs = [database executeQuery:sql];
        while ([rs next]) {
            Goods *goods = [[Goods alloc] init];
            goods.goodsId = [rs stringForColumn:@"Id"];
            goods.goodsName = [rs stringForColumn:@"goodsName"];
            goods.goodsInfo = [rs stringForColumn:@"goodsInfo"];
            goods.price = [rs stringForColumn:@"Price"];
            goods.sell = [rs stringForColumn:@"Sell"];
            goods.count = [NSString stringWithFormat:@"%d",[rs intForColumn:@"Count"]];
            [market addObject:goods];
        }
        [rs close];
    }
    return market;
}


- (NSMutableArray *) getAllGoodsName   //查询所有库存货物名
{
    NSMutableArray *nameArray = [[NSMutableArray alloc]init];
    NSString *sql = [NSString stringWithFormat:@"select * from %@",@"GOODS"];
    NSString *nameString = [[NSString alloc]init];
    FMResultSet *rs = [database executeQuery:sql];
    while ([rs next]) {
        nameString = [rs stringForColumn:@"goodsName"];
        [nameArray addObject:nameString];
    }
    [rs close];
    return nameArray;
    
}

- (NSMutableArray *) getUncheckedList:(NSInteger)flag
{
    NSString *sql = @"";
    NSMutableArray *myArray = [[NSMutableArray alloc]init];
    
    if (flag == 0)
    {
        sql = [NSString stringWithFormat:@"select * from %@ where Permission = '0'",@"SELLLIST"];
        FMResultSet *rs = [database executeQuery:sql];
        while ([rs next]) {
            listCheck *list=[[listCheck alloc]init];
            list.goodsName = [rs stringForColumn:@"goodsName"];
            list.Id = [rs intForColumnIndex:0];
            list.Count = [NSString stringWithFormat:@"%d",[rs intForColumn:@"Count"]];
            list.Price = [rs stringForColumn:@"Price"];
            list.check = [rs intForColumn:@"Permission"];
            [myArray addObject:list];
        }
        [rs close];
    }else if (flag == 1)
    {
        sql = [NSString stringWithFormat:@"select * from %@ where Permission = '0'",@"BUYLIST"];
        FMResultSet *rs = [database executeQuery:sql];
        while ([rs next]) {
            listCheck *list=[[listCheck alloc]init];
            list.goodsName = [rs stringForColumn:@"goodsName"];
            list.Id = [rs intForColumnIndex:0];
            list.Count = [NSString stringWithFormat:@"%d",[rs intForColumn:@"Count"]];
            list.Price = [rs stringForColumn:@"Price"];
            list.check = [rs intForColumn:@"Permission"];
            list.goodsInfo = [rs stringForColumn:@"goodsInfo"];
            list.Category = [rs stringForColumn:@"Category"];
            [myArray addObject:list];
        }
        [rs close];
    }
    
    
    return myArray;
}

- (NSMutableArray *)getFlagValue:(NSInteger)flag   //查询日志
{
    NSString *sql = @"";
    
    switch (flag) {
        case 0:
            sql = [NSString stringWithFormat:@"select * from %@",@"LOG"];
            break;
        case 1:
            sql = [NSString stringWithFormat:@"select * from %@ where Type = '新建进货单' ",@"LOG"];
            break;
        case 2:
            sql = [NSString stringWithFormat:@"select * from %@  where Type = '进货'",@"LOG"];
            break;
        case 3:
            sql = [NSString stringWithFormat:@"select * from %@ where Type = '注册用户' or Type = '登陆' or Type = '修改密码'",@"LOG"];
            break;
            
        case 4:
            sql = [NSString stringWithFormat:@"select * from %@ where Type = '更新'",@"LOG"];
            break;
            
        default:
            break;
    }
    
    NSMutableArray *m_array = [[NSMutableArray alloc] init] ;
    FMResultSet *rs = [database executeQuery:sql];
    while ([rs next]) {
        dbLog *log = [[dbLog alloc] init];
        log.time = [rs stringForColumn:@"Time"];
        log.content = [rs stringForColumn:@"Content"];
        log.person = [rs stringForColumn:@"person"];
        [m_array addObject:log];
    }
    [rs close];
    return m_array;
}

- (BOOL)modifyGoodsInfo:(NSString *)name category:(NSString *)category info:(NSString *)info
{
    BOOL success;
    
    NSString *sql = [NSString stringWithFormat:@"update %@ set Category = ? goodsInfo = ? where goodsName = %@  ",@"GOODS",name];
    
    [database executeUpdate:sql,category,info];
    
    if ([database hadError]) {
        NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        success = NO;
    }
    [self addLog:[NSString stringWithFormat:@"修改了商品%@的信息,分类为:%@,简介为:%@",name,category,info] type:UPDATE];
    success = YES;
    
    
    
    return success;
}


- (BOOL)isSelled:(NSString *)name
{
    BOOL success;
    
    NSString *sql_1 = [NSString stringWithFormat:@"select * from SELLCOUNT where goodsName = ?"];
    FMResultSet *rs_1 = [database executeQuery:sql_1,name];
    while ([rs_1 next]) {
        success = YES;
    }
    [rs_1 close];
    success = NO;
    
    return success;
}

//查询当前物品数量
- (NSString *)getGoodsCount:(NSString *)name
{
    NSString *str = @"";
    NSString *sql = [NSString stringWithFormat:@"select Count from GOODS where goodsName = ?"];                      /* 有些问题啊  */
    FMResultSet *rs = [database executeQuery:sql,name];
    while ([rs next]) {
        str = [NSString stringWithFormat:@"%d",[rs intForColumnIndex:0]];
    }
    [rs close];
    NSLog(@"%@物品数量=%@",name,str);
    return str;
}

- (BOOL)newCountValue:(NSString *)name count:(NSString *)count price:(NSString *)price   //新增销售表的细则
{
    BOOL success;
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (goodsId,Count,goodsName) VALUES (?,?,?)",@"SELLCOUNT"];
    [database executeUpdate:sql,[NSNull null],[NSNumber numberWithInt:[count intValue]],name];
    
    NSString * sql_1 = [NSString stringWithFormat:@"update Sell =? from GOODS where goodsName = ?"];
    [database executeUpdate:sql_1,price,name];
    
    if ([database hadError]) {
        NSLog(@"Err insertEscore %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        success = NO;
    }
    [self addLog:[NSString stringWithFormat:@"销售了一个商品:%@,数量:%@, 价格:%@",name,count,price] type:SELL_GOODS];
    success = YES;
    
    return success;
}

- (NSInteger)calculatTotal:(NSInteger)tag
{
    NSInteger total = 0;
    
    NSString *sql = @"";
    switch (tag) {
        case 0://计算销售额
            sql = [NSString stringWithFormat:@"select sum(GOODS.Sell*SELLCOUNT.Count) from GOODS,SELLCOUNT where GOODS.goodsName = SELLCOUNT.goodsName"];//
            break;
        case 1://计算库存总额(全部按照sell卖掉)
           // sql = [NSString stringWithFormat:@"select sum(Sell*(GOODS.Count-SELLCOUNT.Count)) from GOODS,SELLCOUNT"];
            break;
        case 2://计算总进价
            sql = [NSString stringWithFormat:@"select sum(Price*Count) from GOODS"];
            break;
        case 3://现利润
            sql = [NSString stringWithFormat:@"select sum((GOODS.Sell-GOODS.Price)*SELLCOUNT.Count) from GOODS,SELLCOUNT where GOODS.goodsName = SELLCOUNT.goodsName"];
            break;
           //
        default:
            break;
    }
    
    FMResultSet *rs = [database executeQuery:sql];
    while ([rs next]) {
        total = [rs intForColumnIndex:0];
    }
    [rs close];
    
    
    return  total;
}



@end
