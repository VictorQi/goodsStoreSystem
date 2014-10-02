//
//  sellViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "sellViewController.h"

@interface sellViewController ()
{
    LMContainsLMComboxScrollView *bgScrollView;
    NSMutableArray *goodnames;
    NSString *namestring;
}
@end

@implementation sellViewController
@synthesize sellPrice,count,grossProfit;
@synthesize mySlider,sliderText;
#define kDropDownListTag 1000

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
    goodnames = [[allDataControll shareSingleton]getAllGoodsName];
    namestring = [goodnames firstObject];
    
    bgScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 70, 320, 400)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    [self setUpBgScrollView];
    
    
    UISlider *slider_1 = [[UISlider alloc]initWithFrame:CGRectMake(103, 285, 192, 31)];
    slider_1.minimumValue = 0.0f;
    slider_1.maximumValue = [[[allDataControll shareSingleton]getGoodsCount:namestring]floatValue];
    slider_1.value = 0.0f;
    [slider_1 addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventTouchUpInside];
    mySlider = slider_1;
    [self.view addSubview:mySlider];
    
    
    UITextField *sellPriceTF = [[UITextField alloc]initWithFrame:CGRectMake(105, 182, 188, 30)];
    [sellPriceTF setBorderStyle:UITextBorderStyleRoundedRect];
    sellPriceTF.autocorrectionType = UITextAutocorrectionTypeNo;
    sellPriceTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    sellPriceTF.userInteractionEnabled = YES;
    sellPriceTF.returnKeyType = UIReturnKeyDone;
    sellPriceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    sellPriceTF.delegate = self;
    sellPrice = sellPriceTF;
    [self.view addSubview:sellPrice];
    
    
    UILabel *label_1 = [[UILabel alloc]initWithFrame:CGRectMake(217, 338, 76, 21)];
    UILabel *label_2 = [[UILabel alloc]initWithFrame:CGRectMake(145, 406, 120, 21)];
    label_1.text = @"0 件";
    label_2.text = @"0 元";
    label_1.textColor = [UIColor orangeColor];
    label_2.textColor = [UIColor redColor];
    sliderText = label_1;
    grossProfit = label_2;
    [self.view addSubview:sliderText];
    [self.view addSubview:grossProfit];
    
    
    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"提交", @"")
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(confirm)];
    self.navigationItem.rightBarButtonItem = confirmButton;
    
    /*
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;*/
    
}

/*- (void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.sellPrice resignFirstResponder];
}*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.sellPrice resignFirstResponder];
    return YES;
}

- (void) confirm
{
    BOOL success = [[allDataControll shareSingleton]insertToSellList:namestring SellPrice:self.sellPrice.text SellCount:count];
    NSString *message = success ? @"操作成功" : @"操作失败";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"仓储管理系统" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onChange:(UISlider *)sender
{
    UISlider *control = sender;
    if (control == mySlider) {
        int value = (int)control.value;
        sliderText.text = [NSString stringWithFormat:@"%d 件",value];
        count = value;
        grossProfit.text = [NSString stringWithFormat:@"%.2f 元",value*[sellPrice.text floatValue]];
    }
}

-(void)setUpBgScrollView
{
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(25, 38 ,56, 21)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"商品名:";
    [bgScrollView addSubview:titleLable];
    
    
    
    LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(102, 34, 188,30)];
    comBox.backgroundColor = [UIColor whiteColor];
    comBox.arrowImgName = @"down_dark0.png";
    
    comBox.titlesList = goodnames;
    comBox.delegate = self;
    comBox.supView = bgScrollView;
    [comBox defaultSettings];
    comBox.tag = kDropDownListTag;
    [bgScrollView addSubview:comBox];
    
}




#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    namestring = [goodnames objectAtIndex:index];
    
    
    NSLog(@"seldected good count is %f",[[[allDataControll shareSingleton]getGoodsCount:namestring]floatValue]);
}
@end
