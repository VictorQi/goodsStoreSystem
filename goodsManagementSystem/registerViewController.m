//
//  registerViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-16.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "registerViewController.h"
#import "IQKeyboardManager.h"
@interface registerViewController ()

@end

@implementation registerViewController
{
    MBProgressHUD *HUD;
}
@synthesize regPicker;
@synthesize regUserName;
@synthesize regUserPSW;
@synthesize regUserPSWConfirm;
@synthesize pickerArray,pickerString;


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
    
    self.pickerArray = [NSArray arrayWithObjects:@"审核人员",@"采购人员",@"销售人员", nil];
    self.pickerString = @"审核人员";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    
    self.regPicker.delegate = self;
    self.regPicker.dataSource = self;
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.regUserPSWConfirm resignFirstResponder];
}

- (IBAction)confirmClick:(UIBarButtonItem *)sender
{
    
    if ([self.regUserPSW.text isEqualToString:self.regUserPSWConfirm.text])
    {
        if([[allDataControll shareSingleton]insertValueIntoUserTable:self.regUserName.text andPSW:self.regUserPSWConfirm.text andCategory:self.pickerString])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"仓储管理系统"
                                                         message:@"注册成功，请返回登陆界面。"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"仓储管理系统"
                                                         message:@"账号已存在，请重新注册。忘记密码请自行修改。"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alertview_1 = [[UIAlertView alloc]initWithTitle:@"Error" message:@"两次密码输入不匹配" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alertview_1 show];
    }
    
}



#pragma mark -- pickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerArray count];
}


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerArray objectAtIndex:row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 320;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.pickerString = [pickerArray objectAtIndex:row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
