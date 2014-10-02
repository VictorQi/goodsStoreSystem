//
//  searchViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "searchViewController.h"
#import "allDataControll.h"

@interface searchViewController ()
{
    LMContainsLMComboxScrollView *bgScrollView;
    Goods *selectedgood;
    NSMutableArray *titleArray;
    NSString *selectedGoodsName;
    NSMutableArray *allGoods;
}
@end

@implementation searchViewController
#define kDropDownListTag 1000
@synthesize sellLabel,priceLabel,categoryLabel,countLabel,infoLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"库存管理";
    
    
    allGoods = [[allDataControll shareSingleton]getKeyGOODSValue:@""];
    titleArray = [[allDataControll shareSingleton]getAllGoodsName];
    
    /*for (Goods *xgoods in allGoods) {
        NSString *title = xgoods.goodsName;
        NSLog(@"all goods array has %@",title);
        [titleArray addObject:title];
    }*/
    
    NSLog(@"view did load titleArray contains %ld,allGoods contains %ld",[titleArray count],[allGoods count]);
    
    selectedgood = [allGoods firstObject];
    selectedGoodsName  = selectedgood.goodsName;
    self.priceLabel.text = selectedgood.price;
    self.sellLabel.text = selectedgood.sell;
    self.countLabel.text = selectedgood.count;
    self.infoLabel.text = selectedgood.goodsInfo;
    self.categoryLabel.text = selectedgood.category;
    NSLog(@"selected good is %@,category is %@",selectedGoodsName,selectedgood.category);
    
    bgScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 70, 320, 400)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    [self setUpBgScrollView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --LMComBoxViewDelegate
-(void)setUpBgScrollView
{
    LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(102, 74, 188,30)];
    comBox.backgroundColor = [UIColor whiteColor];
    comBox.arrowImgName = @"down_dark0.png";
    
    comBox.titlesList = titleArray;
    comBox.delegate = self;
    comBox.supView = bgScrollView;
    [comBox defaultSettings];
    comBox.tag = kDropDownListTag;
    [bgScrollView addSubview:comBox];
    
}

-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    selectedGoodsName = [titleArray objectAtIndex:index];
    selectedgood = [allGoods objectAtIndex:index];
    self.priceLabel.text = selectedgood.price;
    self.sellLabel.text = selectedgood.sell;
    self.countLabel.text = selectedgood.count;
    self.infoLabel.text = selectedgood.goodsInfo;
    self.categoryLabel.text = selectedgood.category;
    NSLog(@"selected good is %@,category is %@",selectedGoodsName,selectedgood.category);
   // NSLog(@"seldected good count is %f",[[[allDataControll shareSingleton]getGoodsCount:namestring]floatValue]);
}




@end
