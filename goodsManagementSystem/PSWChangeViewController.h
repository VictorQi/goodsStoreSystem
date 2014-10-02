//
//  PSWChangeViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-16.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "allDataControll.h"

@interface PSWChangeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *PSWname;
@property (strong, nonatomic) IBOutlet UITextField *PSWUnique;
@property (strong, nonatomic) IBOutlet UITextField *PSWPassword;
@property (strong, nonatomic) IBOutlet UITextField *PSWPasswordConfim;

@end
