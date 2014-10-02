//
//  accountPermission.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-18.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "accountPermission.h"

@implementation accountPermission
@synthesize buy,log,sell,search;
@synthesize profit;

- (id) init
{
    if (self == [super init]) {
    
    }
    return self;
}
static accountPermission *sharedSingleton = nil; //权限静态实例设置
+(accountPermission*) sharePermission
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedSingleton = [[accountPermission alloc]init];
    });
    return sharedSingleton;
}
//设置权限
- (void) setPermission:(NSString *)category
{
    if ([category isEqualToString:@"审核人员"]) {
        self.buy = YES;
        self.sell = YES;
        self.search = YES;
        self.log = NO;
        self.profit = NO;
       // self.update = YES;
    }
    else if([category isEqualToString:@"采购人员"]){
        self.buy = YES;
        self.sell = NO;
        self.search = YES;
        self.log = NO;
        self.profit = NO;
        //self.update = NO;
    }
    else if([category isEqualToString:@"销售人员"]){
        self.buy = NO;
        self.sell = YES;
        self.search = YES;
        self.log = NO;
        self.profit = NO;
       // self.update = NO;
    }
    else if([category isEqualToString:@"经理"]){
        self.buy = YES;
        self.sell = YES;
        self.search = YES;
        self.log = YES;
        self.profit = YES;
       // self.update = YES;
    }
}
//注销登陆
- (void) logOut
{
    self.buy = NO;
    self.sell = NO;
    self.search = NO;
    self.log = NO;
    self.profit = NO;
   // self.update = NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"flag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
