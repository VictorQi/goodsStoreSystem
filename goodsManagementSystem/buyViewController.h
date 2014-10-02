//
//  buyViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "allDataControll.h"
#import "IQKeyboardManager.h"
@interface buyViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *goodscount;
@property (strong, nonatomic) IBOutlet UITextField *info;

@property (strong, nonatomic) IBOutlet UIPickerView *category;

@property (nonatomic,retain) NSString *categoryString;
@property (nonatomic,retain) NSArray  *categoryArray;

@end
