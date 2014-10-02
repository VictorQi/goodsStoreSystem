//
//  accountPermission.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-18.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface accountPermission : NSObject
{
    BOOL buy;
    BOOL sell;
    BOOL search;
    BOOL log;
    BOOL update;
    BOOL profit;
}
@property (nonatomic, assign) BOOL buy;
@property (nonatomic, assign) BOOL sell;
@property (nonatomic, assign) BOOL search;
@property (nonatomic, assign) BOOL log;
//@property (nonatomic, assign) BOOL update;
@property (nonatomic, assign) BOOL profit;

- (void) setPermission:(NSString *)category;
+ (accountPermission *) sharePermission;
- (void) logOut;
@end
