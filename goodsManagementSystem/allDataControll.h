//
//  allDataControll.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-17.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "databaseHandler.h"
#import "Goods.h"
#import "sellCount.h"
#import "FormatTime.h"
#import "listCheck.h"
#import "accountPermission.h"
#import "dbLog.h"
#import "listCheck.h"


@interface allDataControll : databaseHandler
+ (allDataControll *)shareSingleton;

- (BOOL) createTable;

- (BOOL) insertValueIntoUserTable:(NSString *)username andPSW:(NSString *)password andCategory:(NSString *)category;

- (BOOL) insertToBuyList:(NSString *)goodname
                Buyprice:(NSString *)price
                 Buycount:(NSInteger)count
                goodInfo:(NSString *)info
            goodCategory:(NSString *)goodcategory;

- (BOOL) insertToSellList:(NSString *)goodname
                SellPrice:(NSString *)price
                 SellCount:(NSInteger)count;

- (NSMutableArray *) getUncheckedList:(NSInteger)flag;

- (NSMutableArray *) getAllGoodsName;

/*- (BOOL)insertListIntoTable:(NSString *)goodsname
                   BuyPrice:(NSInteger)price
                  SellPrice:(NSInteger)sellprice
                   BuyCount:(NSInteger)buycount
                  SellCount:(NSInteger)sellcount
                  goodsInfo:(NSString *)info
                   Category:(NSString *)category
                     listId:(NSInteger)listid
                 Permission:(BOOL)check;*/

- (BOOL)insertValueIntoTableInfo:(NSString *)info
                         andName:(NSString *)name
                        andPrice:(NSString *)price
                         andSell:(NSString *)sell
                        andCount:(NSInteger)count
                     andCategory:(NSString *)category;

- (BOOL) updateCountValue:(NSString *)name
                    count:(NSString *)count
                    price:(NSString *)price;

- (NSString *)login:(NSString *)username
                   :(NSString *)password;

- (BOOL) addLog:(NSString *)content
           type:(NSString *)type;

- (void) deleteValueWithName:(NSString *)name ;

- (BOOL)changePassword:(NSString *)username newpassword:(NSString *)newpassword uniqueId:(NSInteger)usersid;

- (NSMutableArray *) getKeyGOODSValue:(NSString *)key;

- (NSMutableArray *)getFlagValue:(NSInteger)flag;

- (BOOL)modifyGoodsInfo:(NSString *)name category:(NSString *)category info:(NSString *)info;

- (BOOL)isSelled:(NSString *)name;

- (NSString *)getGoodsCount:(NSString *)name;

- (BOOL)newCountValue:(NSString *)name count:(NSString *)count price:(NSString *)price ;

- (NSInteger)calculatTotal:(NSInteger)tag;

- (BOOL) setPermissionByType:(NSString *)listtype
                   andListId:(NSInteger)listid
                 andListName:(NSString *)name
                    andCount:(NSString *)count
                    andPrice:(NSString *)price
                 andCategoty:(NSString *)category
                     andInfo:(NSString *)info
              withPermission:(NSInteger)permissionallow;

@end
