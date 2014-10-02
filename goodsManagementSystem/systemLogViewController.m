//
//  systemLogViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "systemLogViewController.h"
//#import "MJRefresh.h"
@interface systemLogViewController ()

@end

@implementation systemLogViewController

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"刷新", @"")
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(confirm)];
    self.navigationItem.rightBarButtonItem = confirmButton;
    self.navigationItem.title = @"系统日志";
    
    logArray = [[allDataControll shareSingleton]getFlagValue:0];
    
    dbLog *log_1 = [logArray firstObject];
    
    NSLog(@"view did load person is %@",log_1.person);
    NSLog(@"view did load time is %@",log_1.time);
    NSLog(@"view did load content is %@",log_1.content);
    NSLog(@"view did load count is %ld",[logArray count]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)confirm
{
    [self.tableView reloadData];
}



#pragma mark --TableViewDelegate



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [logArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dbLog *log_1 = [logArray objectAtIndex:indexPath.row];
    NSString * text = log_1.content;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:FONT_SIZE] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier  = @"Cell";
    NSLog(@"deldgate init");
    
    MyCell * cell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // 如果没有,则创建
    if (!cell) {
        
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSLog(@"create cell success!");
    }else
    {   //防止cell重叠
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    
    dbLog * textArray = [logArray objectAtIndex:indexPath.row];
    NSString *timeString = [NSString stringWithFormat:@",Time is %@",textArray.time];
    NSString *text = [textArray.content stringByAppendingString:timeString];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setMinimumScaleFactor:FONT_SIZE];
    [label setNumberOfLines:0];
    [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [label setTag:1];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}];
    
    CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize size = rect.size;
    
    if (!label) {
        label = (UILabel *)[cell viewWithTag:1];
    }
    
    label.text = text;
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    [cell.contentView addSubview:label];
    
    return cell;
}


@end
