//
//  PSWChangeViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-16.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "PSWChangeViewController.h"

@interface PSWChangeViewController ()

@end

@implementation PSWChangeViewController

@synthesize PSWname,PSWPassword,PSWPasswordConfim,PSWUnique;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
}

- (void) dismissKeyboard
{
    [[IQKeyboardManager sharedManager]setEnable:YES];
    [PSWPasswordConfim resignFirstResponder];
    
}

- (IBAction)confirmBTClick:(id)sender
{
    if (![self.PSWname.text isEqualToString:@""]||![self.PSWPassword.text isEqualToString:@""]||![self.PSWPasswordConfim.text isEqualToString:@""])
    {
        
        NSInteger x = [self.PSWUnique.text integerValue];
        if ([self.PSWPassword.text isEqualToString:self.PSWPasswordConfim.text]) {
           /* BOOL success = [[allDataControll shareSingleton]changePassword:self.PSWname.text
                                                                  password:self.PSWPasswordConfim.text
                                                                  uniqueId:x];*/
            BOOL success = [[allDataControll shareSingleton]changePassword:self.PSWname.text newpassword:self.PSWPasswordConfim.text uniqueId:x];
            if (success) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"仓储管理系统"
                                                               message:@"密码更改成功！"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"仓储管理系统"
                                                               message:@"失败，请确认是否输入正确的识别码或者账户名！"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
            }
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"仓储管理系统"
                                                           message:@"两次密码输入不相同，请重新输入"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"仓储管理系统"
                                                       message:@"请将内容输入完整！"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }
}


@end
