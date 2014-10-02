//
//  dbLog.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-18.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dbLog : NSObject   //用来存放登陆日志 
{
    NSString *content;
    NSString *time;
    NSString *ID;
    NSString *person;
}
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *person;
@end
