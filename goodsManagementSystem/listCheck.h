//
//  listCheck.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-22.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listCheck : NSObject
{
    NSInteger Id;
    NSString *goodsName;
    NSString *Price;
    NSString *goodsInfo;
    NSString *Count;
    NSString *Category;
    NSString *Time;
    NSString *Checker;
    BOOL check;
}
@property (nonatomic) NSInteger Id;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *Price;
@property (nonatomic,copy) NSString *goodsInfo;
@property (nonatomic,copy) NSString *Count;
@property (nonatomic,copy) NSString *Category;
@property (nonatomic,copy) NSString *Time;
@property (nonatomic,copy) NSString *Checker;
@property (nonatomic) BOOL check;
@end
