//
//  MyGoodsManagementViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-16.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "MyGoodsManagementViewController.h"

@interface MyGoodsManagementViewController ()

@end

@implementation MyGoodsManagementViewController
{
    MBProgressHUD *HUD;
}
@synthesize userNameTF;
@synthesize userPasswordTF;



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.userPasswordTF resignFirstResponder];
}

- (IBAction)logInClick:(UIButton *)sender
{
    if ([self.userPasswordTF.text isEqualToString:@"admin"] &&[self.userNameTF.text isEqualToString:@"admin"]) {
        [[accountPermission sharePermission] setPermission:@"经理"];
        [[NSUserDefaults standardUserDefaults] setValue:@"经理" forKey:@"flag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"仓储管理系统"
                                                            message:@"登陆成功"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else if ([[allDataControll shareSingleton]login:self.userNameTF.text :self.userPasswordTF.text]) {
        NSString *permission = [[allDataControll shareSingleton] login:self.userNameTF.text :self.userPasswordTF.text];
        if (!permission) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"仓储管理系统"
                                                            message:@"账号密码错误！新用户请注册，忘记密码请自行修改！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [self performSegueWithIdentifier:@"login" sender:self];
            
        }
        [[NSUserDefaults standardUserDefaults] setValue:permission forKey:@"flag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[accountPermission sharePermission] setPermission:permission];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"仓储管理系统"
                                                            message:@"登陆成功"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"仓储管理系统"
                                                            message:@"账号密码错误！新用户请注册，忘记密码请自行修改！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    
}


@end
