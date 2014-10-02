//
//  systemLogViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "allDataControll.h"
#import "MyCell.h"


@interface systemLogViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *logArray;
}

@end
