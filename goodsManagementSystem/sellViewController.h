//
//  sellViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"
#import "LMContainsLMComboxScrollView.h"
#import "IQKeyboardManager.h"
#import "allDataControll.h"


@interface sellViewController : UIViewController<LMComBoxViewDelegate>
@property (nonatomic) NSInteger count;
@property (strong,nonatomic) UISlider *mySlider;
@property (strong,nonatomic) UITextField *sellPrice;
@property (strong,nonatomic) UILabel *sliderText;
@property (strong,nonatomic) UILabel *grossProfit;


@end
