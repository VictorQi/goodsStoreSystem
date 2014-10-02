//
//  MyGoodsManagementAppDelegate.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-16.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "MyGoodsManagementAppDelegate.h"

@implementation MyGoodsManagementAppDelegate




- (void) initDataBase
{
    BOOL create_flag =[[allDataControll shareSingleton]createTable];
    if(!create_flag){
        NSLog(@"-----初始化数据库失败----");}
    else{
        NSLog(@"初始化成功");}
    assert(create_flag);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[IQKeyboardManager sharedManager]setEnable:YES];  //IQKeyboardManager打开
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:50]; //设置距离键盘多少远处点击关闭键盘
    
    [self initDataBase];
    
    
   /* NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSString *dbpath = [dir stringByAppendingPathComponent:@"db.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbpath];
    
    if (![db open]) {
        NSLog(@"cannot open the database");
    }
    */
    NSString *flag = [[NSUserDefaults standardUserDefaults] objectForKey:@"flag"];
    if (flag) {
        [[accountPermission sharePermission] setPermission:flag];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths);
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
