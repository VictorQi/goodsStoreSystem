//
//  rootTableViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "rootTableViewController.h"

@interface rootTableViewController ()
{
    NSString *flag;
}
@end

@implementation rootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    flag = [[NSUserDefaults standardUserDefaults]objectForKey:@"flag"];
    NSLog(@"flag is %@ ",flag);
    
    if ([flag isEqualToString:@"采购人员"])
    {
        self.sellcell.accessoryType = UITableViewCellAccessoryNone;
        self.logsell.accessoryType = UITableViewCellAccessoryNone;
        self.checkcell.accessoryType = UITableViewCellAccessoryNone;
        self.profitcell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if ([flag isEqualToString:@"销售人员"])
    {
        self.buycell.accessoryType = UITableViewCellAccessoryNone;
        self.logsell.accessoryType = UITableViewCellAccessoryNone;
        self.checkcell.accessoryType = UITableViewCellAccessoryNone;
        self.profitcell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if ([flag isEqualToString:@"审核人员"])
    {
        self.sellcell.accessoryType = UITableViewCellAccessoryNone;
        self.logsell.accessoryType = UITableViewCellAccessoryNone;
        self.buycell.accessoryType = UITableViewCellAccessoryNone;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)logout:(UIBarButtonItem *)sender
{
    
    if (flag) {
        [[accountPermission sharePermission]logOut];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"仓储管理系统" message:@"注销成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    return 4;
}
//[flag isEqualToString:@"销售人员"]
//[flag isEqualToString:@"审核人员"]
//[flag isEqualToString:@"采购人员"]

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            switch (indexPath.row)
        {
            case 0:
                if ([flag isEqualToString:@"销售人员"] ||[flag isEqualToString:@"审核人员"])
                {
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
                
            default:
                break;
        }
            break;
        case 1:
            switch (indexPath.row)
        {
            case 0:
                if ([flag isEqualToString:@"采购人员"] ||[flag isEqualToString:@"审核人员"])
                {
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
                
            default:
                break;
        }
            break;
        case 2:
            switch (indexPath.row)
        {
            case 0:
                if ([flag isEqualToString:@"采购人员"] ||[flag isEqualToString:@"审核人员"]||[flag isEqualToString:@"销售人员"] )
                {
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
            case 1:
                if ([flag isEqualToString:@"采购人员"]||[flag isEqualToString:@"销售人员"] ) {
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
            case 2:
                if ([flag isEqualToString:@"采购人员"] ||[flag isEqualToString:@"审核人员"]||[flag isEqualToString:@"销售人员"] )
                {
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
            default:
                break;
        }
            break;
        default:
            break;
    }
}*/
@end
