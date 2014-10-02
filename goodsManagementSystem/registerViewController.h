//
//  registerViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-16.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "allDataControll.h"
@interface registerViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *regUserName;
@property (strong, nonatomic) IBOutlet UITextField *regUserPSW;
@property (strong, nonatomic) IBOutlet UITextField *regUserPSWConfirm;
@property (strong, nonatomic) IBOutlet UIPickerView *regPicker;

@property (strong, nonatomic) NSString *pickerString;
@property (strong, nonatomic) NSArray *pickerArray;





@end
