//
//  buyViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "buyViewController.h"

@interface buyViewController ()

@end

@implementation buyViewController

@synthesize name,price,category,goodscount,info;
@synthesize categoryArray;
@synthesize categoryString;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *flag = [[NSUserDefaults standardUserDefaults] objectForKey:@"flag"];
    NSLog(@"buyview flag = %@",flag);
    self.categoryArray = [NSArray arrayWithObjects:@"图书",@"服装",@"日用品",@"家电",@"办公耗材",@"体育用品", nil];
    self.categoryString = @"图书";
    self.category.delegate = self;
    self.category.dataSource = self;
    
    
    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"提交", @"")
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(confirm)];
    self.navigationItem.rightBarButtonItem = confirmButton;
    
    
    
}


- (void) confirm
{
    BOOL success = [[allDataControll shareSingleton]insertToBuyList:self.name.text
                                                           Buyprice:self.price.text
                                                           Buycount:[self.goodscount.text integerValue]
                                                           goodInfo:self.info.text
                                                       goodCategory:self.categoryString];
    NSString *message = success ? @"操作成功" : @"操作失败";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"仓储管理系统" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -pickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [categoryArray count];
}


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [categoryArray objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.categoryString = [categoryArray objectAtIndex:row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
