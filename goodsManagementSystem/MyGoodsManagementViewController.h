//
//  MyGoodsManagementViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-16.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "IQKeyboardManager.h"
#import "allDataControll.h"

@interface MyGoodsManagementViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *userPasswordTF;
@property (strong, nonatomic) IBOutlet UIButton *registerBT;
@property (strong, nonatomic) IBOutlet UIButton *changePswBT;
@property (strong, nonatomic) IBOutlet UIButton *loginBT;



@end
