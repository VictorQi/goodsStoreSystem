//
//  profit.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "profit.h"

@interface profit ()

@end

@implementation profit

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"利润";
    self.sellLabel.text = [NSString stringWithFormat:@"%ld",[[allDataControll shareSingleton] calculatTotal:0]];
    //self.stock.text = [NSString stringWithFormat:@"%ld",[[allDataControll shareSingleton] calculatTotal:1]];
    self.capital.text = [NSString stringWithFormat:@"%ld",[[allDataControll shareSingleton] calculatTotal:2]];
   // self.expect.text =
  //  NSInteger profit = [self.sellLabel.text integerValue]-[self.capital.text intValue];
    self.totalProfit.text = [NSString stringWithFormat:@"%ld",[[allDataControll shareSingleton] calculatTotal:3]];//[NSString stringWithFormat:@"%ld",profit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
