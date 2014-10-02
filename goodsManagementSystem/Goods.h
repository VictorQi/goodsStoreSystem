//
//  Goods.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-18.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject
{
    NSString *goodsId;
    NSString *goodsName;
    NSString *price;
    NSString *goodsInfo;
    NSString *count;
    NSString *category;
    NSString *sell;
}
@property (nonatomic,copy) NSString *goodsId;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *goodsInfo;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *sell;

@end
