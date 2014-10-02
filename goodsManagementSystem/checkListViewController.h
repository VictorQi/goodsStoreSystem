//
//  checkListViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"
#import "LMContainsLMComboxScrollView.h"
#import "allDataControll.h"


@interface checkListViewController : UIViewController<LMComBoxViewDelegate>

@property (strong, nonatomic) UISegmentedControl *listSelected;

//@property (strong, nonatomic) IBOutlet UILabel *listId;

@property (strong, nonatomic) IBOutlet UILabel *listName;

@property (strong, nonatomic) IBOutlet UILabel *listCount;

@property (strong, nonatomic) IBOutlet UILabel *listPrice;

@property (strong, nonatomic) UISwitch *permissionSwitch;

@property (strong, nonatomic) IBOutlet UILabel *staticCount;

@property (strong, nonatomic) IBOutlet UILabel *staticPrice;


@end
