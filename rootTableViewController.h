//
//  rootTableViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "allDataControll.h"
#import "profit.h"
#import "searchViewController.h"
#import "systemLogViewController.h"
#import "buyViewController.h"
#import "checkListViewController.h"
@interface rootTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *buycell;
@property (strong, nonatomic) IBOutlet UITableViewCell *sellcell;
@property (strong, nonatomic) IBOutlet UITableViewCell *logsell;
@property (strong, nonatomic) IBOutlet UITableViewCell *profitcell;
@property (strong, nonatomic) IBOutlet UITableViewCell *goodscell;
@property (strong, nonatomic) IBOutlet UITableViewCell *checkcell;

@end
