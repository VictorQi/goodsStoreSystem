//
//  searchViewController.h
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"
#import "LMContainsLMComboxScrollView.h"
#import "IQKeyboardManager.h"
@interface searchViewController : UIViewController<LMComBoxViewDelegate>
//@property (strong, nonatomic) IBOutlet UISearchBar *searchingText;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *sellLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

@end
